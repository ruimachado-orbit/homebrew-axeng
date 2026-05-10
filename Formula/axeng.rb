# frozen_string_literal: true

class Axeng < Formula
  desc "Engineering Manager Accelerator — AI chief of staff for GitHub, Linear, calendar, and team"
  homepage "https://github.com/ruimachado-orbit/axeng"
  license "MIT"
  url "https://github.com/ruimachado-orbit/axeng.git"
  version "1.0.0"

  head "https://github.com/ruimachado-orbit/axeng.git", branch: "main"

  depends_on "docker"

  def install
    # bin/ scripts are part of the cloned repo (installed to Cellar by homebrew via git clone)
    bin.install Dir["bin/*"] if (prefix/"bin").exist?

    # Create config dir and copy template if not already present
    config_dir = prefix/"config"
    config_dir.mkpath
    example = config_dir/"config.yaml.example"
    if example.exist? && !(config_dir/"config.yaml").exist?
      cp example, config_dir/"config.yaml"
    end
  end

  def post_install
    ohai "🎉 Axeng installed!"
    puts ""
    puts "Next steps:"
    puts ""
    puts "  1. Configure:"
    puts "     cp #{prefix}/.env.example #{prefix}/.env"
    puts "     # Then edit #{prefix}/.env with your API keys:"
    puts "     #   LINEAR_API_KEY, GITHUB_TOKEN, ANTHROPIC_API_KEY (or OPENAI_API_KEY)"
    puts ""
    puts "     # Also edit: #{prefix}/config/config.yaml"
    puts "     #   (your GitHub orgs, Linear project IDs, team)"
    puts ""
    puts "  2. Start:"
    puts "     axeng"
    puts ""
    puts "  3. Open: http://localhost:8501"
    puts ""
    puts "Commands:"
    puts "  axeng        Start"
    puts "  axeng-stop   Stop"
    puts "  axeng-logs   View logs"
    puts "  axeng-update Pull latest + rebuild"
  end

  test do
    system "docker", "compose", "version"
  end

  def caveats
    <<~CAVEATS
      Axeng requires Docker and API keys to run.

      Required keys in .env:
        LINEAR_API_KEY   — linear.app/settings/api
        GITHUB_TOKEN     — github.com/settings/tokens
        ANTHROPIC_API_KEY — anthropic.com/api (or OPENAI_API_KEY)

      More info: https://github.com/ruimachado-orbit/axeng
    CAVEATS
  end
end