class Kent < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-llc/kent"
  version "2.2.0"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-llc/tap"
  end

  depends_on "ripgrep"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.2.0/kent_2.2.0_darwin_arm64.tar.gz"
      sha256 "a8face4131ba238bf00dd3568530e97040e1be21b4b0d2e8b8c602ea50891443"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.2.0/kent_2.2.0_linux_arm64.tar.gz"
      sha256 "bb1fc27c844a2914a060841d8887c41d41972ea96bd11e45547d280c1b7c2029"
    end
    on_intel do
      url "https://github.com/respawn-llc/kent/releases/download/v2.2.0/kent_2.2.0_linux_amd64.tar.gz"
      sha256 "b95f950be0a2653bb8902ebc4c796636c0e00a6109f516f08e49073ee621c96c"
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
