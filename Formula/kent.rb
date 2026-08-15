class Kent < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-llc/kent"
  url "https://github.com/respawn-llc/kent/releases/download/v2.7.0/kent_2.7.0_darwin_arm64.tar.gz"
  sha256 "529f3c72ccffc00068793715882ecfcfc1b926b5b82734be492522f1db8b0a63"
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
      url "https://github.com/respawn-llc/kent/releases/download/v2.7.0/kent_2.7.0_linux_arm64.tar.gz"
      sha256 "6cdc28957ad6c8fb9d84d76fbdc63007ede276266168b8c6c094f2ba0b5b7a78"
    end
    on_intel do
      url "https://github.com/respawn-llc/kent/releases/download/v2.7.0/kent_2.7.0_linux_amd64.tar.gz"
      sha256 "9972aad8f66233cab82800bbc17a69a1945767632b9b732936f546ee3ea25cca"
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
