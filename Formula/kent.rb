class Kent < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-llc/kent"
  version "2.1.1"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-llc/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "49ef131ff9c2634b98d124c5bb2ad963599cd07cb557ca6883ae8bf5d6e86c27"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "24612cc9ab684dd288b6b1ada4006ad1f4a22266b0144cf0d559f744de229e4a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1a39a5aee856d6950fcd6c07cd398093eddd77e010e4f8bd697811a13ad20af0"
  end

  depends_on "ripgrep"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.1.1/kent_2.1.1_darwin_arm64.tar.gz"
      sha256 "9db5b59ca3275cfaa9e0ba331c3ad7ef52f615b5060f939717f932eaa9f11c71"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.1.1/kent_2.1.1_linux_arm64.tar.gz"
      sha256 "2967ab414643073d70b63643bb8b88e64429a1d85a992db27006eaa65fb87b99"
    end
    on_intel do
      url "https://github.com/respawn-llc/kent/releases/download/v2.1.1/kent_2.1.1_linux_amd64.tar.gz"
      sha256 "c9be61c9e22fe4d7c3ff0a2e9e66e4e44a67982e7bbeb0604fd4426491df82b1"
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
