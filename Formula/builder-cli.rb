class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v1.2.2.tar.gz"
  sha256 "2217e4947bcebb96b9413fcf3439f5998b35fa6c6014cb331401bb2c91e6080c"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "57c87227091c5cec47242f43d4a8a7497501f2c57704a69b9dc515e0cd58bf5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "83886759236892621a75e18c17e442d231072320497b576e94f2d1b7f1bbfd96"
  end

  depends_on "go" => :build
  depends_on "git"
  depends_on "ripgrep"

  def install
    ENV["BUILDER_VERSION"] = version.to_s
    system "bash", "scripts/build.sh", "--output", bin/"builder"
  end

  def post_install
    output = Utils.safe_popen_read(bin/"builder", "service", "restart", "--if-installed").strip
    ohai output unless output.empty?
  rescue => e
    opoo "Builder background service restart failed after update: #{e.message}"
  end

  def caveats
    <<~EOS
      Homebrew does not install the Builder server background service.

      If you want one shared background server for all Builder frontends (~70 MB RAM), run:
        builder service install
    EOS
  end

  test do
    assert_match "Usage of builder:", shell_output("#{bin}/builder --help 2>&1")
  end
end
