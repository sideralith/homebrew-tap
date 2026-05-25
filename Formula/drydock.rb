class Drydock < Formula
  desc "Containerized Claude Code workspace with credential isolation"
  homepage "https://github.com/sideralith/drydock"
  url "https://github.com/sideralith/drydock/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "49ebdc0871c18dc8a5568842239dbc43fee4701b668f73f73e3a5e19ac55f37f"
  license "MIT"
  head "https://github.com/sideralith/drydock.git", branch: "main"

  depends_on "jq"
  depends_on "rsync"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/drydock"
  end

  def caveats
    <<~EOS
      drydock requires Docker to be installed and running on the host.
        - macOS:  https://docs.docker.com/desktop/install/mac-install/
        - Linux:  https://docs.docker.com/engine/install/

      First-time setup (one-time, ~5 minutes):
        drydock build

      Then in any project:
        cd <your-project>
        drydock                # launches Claude Code inside the container

      Engram (optional persistent memory) is auto-detected if present on PATH.
      The shared-engram mode prompt that ships with install.sh is NOT exposed
      via Homebrew — create the sentinel manually if you want shared mode on
      native Linux (see INV-5 in docs/security.md):
        touch ~/.config/drydock/engram-shared

      Docs:  https://github.com/sideralith/drydock
    EOS
  end

  test do
    assert_match(/drydock/, shell_output("#{bin}/drydock version"))
  end
end
