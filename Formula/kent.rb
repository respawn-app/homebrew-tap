class Kent < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-llc/kent"
  version "2.3.1"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-llc/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8a34c12eb47be8223a0f5cef42ed3330db464b978313e63ea6c57aa7c3b340cc"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "246d5e3999cc227782bf10bebe6aeaf232a1fd015bd70180aaab5ba944dcf085"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "94327fad158074cdc5622fe369e678a3b3d63c73927e1e57b225cd3efce86fd3"
  end

  depends_on "ripgrep"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.3.1/kent_2.3.1_darwin_arm64.tar.gz"
      sha256 "97187101d36bd961015961319e184a76dc68461391cf05f59b2cccc52a72c594"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.3.1/kent_2.3.1_linux_arm64.tar.gz"
      sha256 "17691e4e1c50a84c50ba6c9ddbc4a9a726c9e7ec778a4341ae99116523bd845b"
    end
    on_intel do
      url "https://github.com/respawn-llc/kent/releases/download/v2.3.1/kent_2.3.1_linux_amd64.tar.gz"
      sha256 "f0c0c42840611fbab70af8f4751d6fe4672cbeeecfc296f3acbfbcf7345f1d79"
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
