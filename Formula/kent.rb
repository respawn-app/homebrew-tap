class Kent < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-llc/kent"
  url "https://github.com/respawn-llc/kent/releases/download/v2.6.1/kent_2.6.1_darwin_arm64.tar.gz"
  sha256 "4d08c4920198ec8029c6145926c7d070fdb327afe0fc2966b133e77148d4a812"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-llc/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "75811c7feb8490d53c302e51aecaa1d5e8627c487573c2578240903834248649"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "79e465c28323e391b8e03f2a3e3d64a5d80752091d55588854f3939702f311ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "296f042ba6435a62beae749bdd6eae241d7c65564e247e72b46b92aaf2856ee9"
  end

  depends_on "ripgrep"

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.6.1/kent_2.6.1_linux_arm64.tar.gz"
      sha256 "2bb21a8abc8a84faebde1cc3f4f38c6854dc3da328bf6d8f9505888613fcdb3e"
    end
    on_intel do
      url "https://github.com/respawn-llc/kent/releases/download/v2.6.1/kent_2.6.1_linux_amd64.tar.gz"
      sha256 "11834ac84e9677b879e1a46cce3e1b7d018948cf4c8d0833246f4287fc773b11"
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
