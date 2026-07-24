class Kent < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-llc/kent"
  version "2.4.0"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-llc/tap"
  end

  depends_on "ripgrep"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.4.0/kent_2.4.0_darwin_arm64.tar.gz"
      sha256 "3f22e0113497fbf7bfa86aef7d4a025ac1c2dd431fc948d7ca59728eff1b300d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/respawn-llc/kent/releases/download/v2.4.0/kent_2.4.0_linux_arm64.tar.gz"
      sha256 "3a750557343a1090051546e9574f1e07ea2669eae1cc31d3e4f9961738a05394"
    end
    on_intel do
      url "https://github.com/respawn-llc/kent/releases/download/v2.4.0/kent_2.4.0_linux_amd64.tar.gz"
      sha256 "34baf66815f7d9b20d665f24331d83039dbdb73a3bb853adf6da07fb0d8d1afd"
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
