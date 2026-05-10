# frozen_string_literal: true

class Axeng < Formula
  desc "Engineering Manager Accelerator — AI chief of staff for GitHub, Linear, calendar, and team"
  homepage "https://github.com/ruimachado-orbit/axeng"
  license "MIT"
  url "https://github.com/ruimachado-orbit/axeng.git"
  version "1.0.0"

  # Clone the latest from main
  head "https://github.com/ruimachado-orbit/axeng.git", branch: "main"

  depends_on "docker"

  def install
    # bin/ scripts are included in the repo
    if (prefix/"bin").exist?
      bin.install Dir["bin/*"]
    end

    # Copy config template
    config_dir = prefix/"config"
    config_dir.mkpath
    if (config_dir/"config.yaml.example").exist? && !(config_dir/"config.yaml").exist?
      cp config_dir/"config.yaml.example", config_dir/"config.yaml"
    end
  end

  def post_install
    ohai "🎉 Axeng installed!"
    puts ""
    puts "Next steps:"
    puts "  1. Configure: #{prefix}/config/config.yaml"
    puts "  2. Copy .env:  cp #{prefix}/config/.env.example #{prefix}/.env  # then add your API keys"
    puts "  3. Start:     axeng"
    puts "  4. Open:      http://localhost:8501"
    puts ""
    puts "Commands:"
    puts "  axeng        # Start (docker compose up -d)"
    puts "  axeng-stop   # Stop"
    puts "  axeng-logs   # View logs"
    puts "  axeng-update # Pull latest + rebuild"
  end

  test do
    system "docker", "compose", "version"
  end

  def caveats
    <<~CAVEATS
      Axeng requires Docker and API keys to run.

      Required keys in .env:
        LINEAR_API_KEY   — from linear.app/settings/api
        GITHUB_TOKEN    — from github.com/settings/tokens
        ANTHROPIC_API_KEY (or OPENAI_API_KEY)

      See: https://github.com/ruimachado-orbit/axeng
    CAVEATS
  end
end