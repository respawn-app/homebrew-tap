class Kent < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-llc/kent"
  version "2.3.0"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-llc/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "5414054bed4ec7149decfc10db3aaceb88de93a4fed6474f55c3c7a192c5a192"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "c096db7586014be2f398dfbf6407cecee0e2fbdf8ef11674e90dc14ac9b7054b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "03143e84e1fca61bae63cc09eb3194f5e79b4ea2b07c26a56c76d4b20bae58ad"
  end

  depends_on "ripgrep"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.3.0/kent_2.3.0_darwin_arm64.tar.gz"
      sha256 "6b1abf2ea5e24f90d80780f289923580a701526974d63b836b5eea397d6da719"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.3.0/kent_2.3.0_linux_arm64.tar.gz"
      sha256 "6f5876654adcfe226dd6ae4e62e397192026bbf8753d4bcf2395b04619389346"
    end
    on_intel do
      url "https://github.com/respawn-llc/kent/releases/download/v2.3.0/kent_2.3.0_linux_amd64.tar.gz"
      sha256 "692215787455990dccd44f665c87f84bb63fe54d4f797ecb3d33d12ad0ca77ce"
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
