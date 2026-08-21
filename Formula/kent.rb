class Kent < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-llc/kent"
  url "https://github.com/respawn-llc/kent/releases/download/v2.7.2/kent_2.7.2_darwin_arm64.tar.gz"
  sha256 "af1a8f6ab391ee67996f5b695a86387278e3ddf1e5b1a92c4ff2127810b9376c"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-llc/tap"
  end

  depends_on "ripgrep"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.7.2/kent_2.7.2_linux_arm64.tar.gz"
      sha256 "01286064bdd5f8fbe634ce304c001bba9815793f8c4f61c2a3f1aebb69f5a6e5"
    end
    on_intel do
      url "https://github.com/respawn-llc/kent/releases/download/v2.7.2/kent_2.7.2_linux_amd64.tar.gz"
      sha256 "21dd8058b97fd28812e52348dc1c37e1dcd6ab46d2b258a0ef345e6864d7986f"
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
