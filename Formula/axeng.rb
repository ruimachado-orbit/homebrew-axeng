# frozen_string_literal: true

class Axeng < Formula
  desc "Engineering Manager Accelerator — AI chief of staff for GitHub, Linear, calendar, and team"
  homepage "https://github.com/ruimachado-orbit/axeng"
  license "GPL-3.0"
  url "https://github.com/ruimachado-orbit/axeng.git", branch: "main"
  version "2.0.0"
  head "https://github.com/ruimachado-orbit/axeng.git", branch: "main"

  depends_on "node"
  depends_on "python@3.12"
  depends_on "gh"

  def install
    # Install the entire repo to libexec
    libexec.install Dir["*"]

    # Create a Python virtual environment
    venv = libexec/"venv"
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv", venv

    # Install Python dependencies in the virtualenv
    system venv/"bin/pip", "install", "--upgrade", "pip"
    system venv/"bin/pip", "install", "-r", libexec/"requirements.txt"

    # Install Node.js dependencies for UI
    cd libexec/"ui/nextjs" do
      system "npm", "install"
    end

    # Create wrapper scripts
    (bin/"axeng").write <<~EOS
      #!/bin/bash
      export AXENG_HOME="#{var}/axeng"
      export PYTHONPATH="#{libexec}/src:$PYTHONPATH"
      export PATH="#{libexec}/ui/nextjs/node_modules/.bin:$PATH"

      # Ensure config directory exists
      mkdir -p "$AXENG_HOME"

      # If no arguments, show help
      if [ $# -eq 0 ]; then
        exec "#{venv}/bin/python3" "#{libexec}/bin/axeng-cli" --help
      fi

      # Run CLI with all arguments
      exec "#{venv}/bin/python3" "#{libexec}/bin/axeng-cli" "$@"
    EOS

    # Create axeng-dev wrapper (starts Next.js UI)
    (bin/"axeng-dev").write <<~EOS
      #!/bin/bash
      cd "#{libexec}/ui/nextjs"
      export AXENG_HOME="#{var}/axeng"
      export PYTHONPATH="#{libexec}/src:$PYTHONPATH"

      echo "🚀 Starting Axeng Next.js UI..."

      # Start API backend in background
      "#{venv}/bin/python3" api_server.py > /tmp/axeng-api.log 2>&1 &
      API_PID=$!

      # Start Next.js
      npm run dev

      # Kill API on exit
      kill $API_PID 2>/dev/null || true
    EOS

    chmod 0755, bin/"axeng"
    chmod 0755, bin/"axeng-dev"

    # Create var directory for user config
    (var/"axeng").mkpath

    # Copy example configs if they don't exist
    unless (var/"axeng/.env").exist?
      cp libexec/".env.example", var/"axeng/.env.example"
    end

    unless (var/"axeng/config.yaml").exist?
      cp libexec/"config/config.yaml.example", var/"axeng/config.yaml.example"
    end
  end

  def post_install
    ohai "🎉 Axeng v2.0 installed with Next.js UI!"
    puts ""
    puts "What's new:"
    puts "  ✨ Next.js UI (replaces Streamlit)"
    puts "  ⚡ 10x faster, no Docker needed"
    puts "  🎨 Modern design with dark mode"
    puts ""
    puts "Setup:"
    puts "  1. Configure interactively:"
    puts "     axeng configure"
    puts ""
    puts "  2. Or manually edit:"
    puts "     #{var}/axeng/.env"
    puts "     #{var}/axeng/config.yaml"
    puts ""
    puts "Start:"
    puts "  axeng start        # Production mode"
    puts "  axeng-dev          # Development mode"
    puts ""
    puts "  Open: http://localhost:3000"
    puts ""
    puts "Other commands:"
    puts "  axeng chat         # Chat interface"
    puts "  axeng stop         # Stop services"
    puts "  axeng status       # Check status"
    puts "  axeng --help       # All commands"
  end

  def caveats
    <<~CAVEATS
      Axeng v2.0 uses Next.js UI (no Docker required).

      Required API keys in #{var}/axeng/.env:
        LINEAR_API_KEY      — linear.app/settings/api
        GITHUB_TOKEN        — github.com/settings/tokens
        ANTHROPIC_API_KEY   — console.anthropic.com (or other LLM provider)

      Configure interactively:
        axeng configure

      Or edit manually:
        #{var}/axeng/.env
        #{var}/axeng/config.yaml

      Start the UI:
        axeng start         → http://localhost:3000 (production)
        axeng-dev           → http://localhost:3000 (development)

      More info: https://github.com/ruimachado-orbit/axeng
    CAVEATS
  end

  test do
    assert_match "axeng", shell_output("#{bin}/axeng --help")
  end
end
