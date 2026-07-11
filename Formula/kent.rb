class Kent < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-llc/kent"
  version "2.2.0"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-llc/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6d7ec5cafdac8ea68d8525601aaf98af5040a09771f59c96e13ec199d4c48d3d"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "cb863d254ab97dfd1f60d368c67a68080ca75f9e29c974af4be6adb665f99228"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "947af8ec988771555b69ee77f6ac4d0ab60071203b121de56360bdf4f9953467"
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
