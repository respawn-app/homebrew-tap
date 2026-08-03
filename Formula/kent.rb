class Kent < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-llc/kent"
  version "2.5.0"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-llc/tap"
  end

  depends_on "ripgrep"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/respawn-llc/kent/releases/download/v2.5.0/kent_2.5.0_darwin_arm64.tar.gz"
    sha256 "b712e8ff87628241d01d3276d3f701931d3e54748ebc1385ece9fd348cac11ea"
  end

  on_linux do
    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.5.0/kent_2.5.0_linux_arm64.tar.gz"
      sha256 "86b02a7c7b63038ab2adcfee0ff47b3c3e82429c9e57389b2aa3098b54475503"
    end
    on_intel do
      url "https://github.com/respawn-llc/kent/releases/download/v2.5.0/kent_2.5.0_linux_amd64.tar.gz"
      sha256 "edb54088d53a42039a7b43a899aff1d281c6af6067d4794c063df47f98f7e56c"
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
