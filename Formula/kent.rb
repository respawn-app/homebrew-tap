class Kent < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-llc/kent"
  version "2.1.0"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-llc/tap"
  end

  depends_on "ripgrep"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.1.0/kent_2.1.0_darwin_arm64.tar.gz"
      sha256 "6c158b2f41e595e46e9dfc32adad59e4040e98443b01d0e99c52792af98e318c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.1.0/kent_2.1.0_linux_arm64.tar.gz"
      sha256 "4f2dd17dfb08fffb8bbda698fafe246210288e386f4c4d7baaab6b7576f6c7b2"
    end
    on_intel do
      url "https://github.com/respawn-llc/kent/releases/download/v2.1.0/kent_2.1.0_linux_amd64.tar.gz"
      sha256 "a7d8950148a4ed0cb91ab7f7a6122389f23f42970af686fd701fc0d270f480f8"
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
