class Kent < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-llc/kent"
  url "https://github.com/respawn-llc/kent/releases/download/v2.6.0/kent_2.6.0_darwin_arm64.tar.gz"
  sha256 "cb220fc24d643247f06339a47d59ffe54bd0923d73b914e369a7e07fd9a707f6"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-llc/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6a2e273133d60b7d75505e6d7d321b1f69dbfa71cd1347564c516997d4586209"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "1963dcfd2a52b65fc79f4de545e1571d2562e217bb2c8a5d033816780718b96b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "574cd3e8142950f785dfd34c259d9b5ff58d10268bf92e14fc7c8115ea2720e0"
  end

  depends_on "ripgrep"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.6.0/kent_2.6.0_linux_arm64.tar.gz"
      sha256 "b86402e67647e480d10d3f6ed9558aadc5ac4a2b63f6541b7e406ce2d0004450"
    end
    on_intel do
      url "https://github.com/respawn-llc/kent/releases/download/v2.6.0/kent_2.6.0_linux_amd64.tar.gz"
      sha256 "35510b8956cee80fb27de41aac6b898ed58484e02af69cfbd502fdd778d8a020"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "kent_#{version}_#{os}_#{arch}" => "kent"
  end

  def post_install
    output = Utils.safe_popen_read(bin/"kent", "service", "restart", "--if-installed").strip
    ohai output unless output.empty?
  rescue => e
    opoo "Kent background service restart failed after update: #{e.message}"
  end

  def caveats
    <<~EOS
      Homebrew does not install the Kent server background service.

      If you want one shared background server for all Kent frontends (~70 MB RAM), run:
        kent service install
    EOS
  end

  test do
    assert_match "Usage of kent:", shell_output("#{bin}/kent --help 2>&1")
  end
end
