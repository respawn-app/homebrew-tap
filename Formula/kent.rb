class Kent < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-llc/kent"
  url "https://github.com/respawn-llc/kent/releases/download/v2.7.1/kent_2.7.1_darwin_arm64.tar.gz"
  sha256 "835e12f55072f0d4b54cb9a1d1bd939189ff4618b5634a2a371591cb725b5c7b"
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
      url "https://github.com/respawn-llc/kent/releases/download/v2.7.1/kent_2.7.1_linux_arm64.tar.gz"
      sha256 "2b7470ead9076ae371a84e63c933887bbad38c241427cbe66069cf24a739a8f1"
    end
    on_intel do
      url "https://github.com/respawn-llc/kent/releases/download/v2.7.1/kent_2.7.1_linux_amd64.tar.gz"
      sha256 "381f2eaa7ffe91c9c8f0164154bdce14e96b249f6d23561e48b1304f801a34a3"
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
