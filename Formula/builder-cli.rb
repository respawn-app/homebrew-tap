class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "6b9681a1e8831d094f40b39858cab36a888d5ef933e9f723acffe6f33d574d05"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "60a282cd9e5d51b839ee793f70de22092f382e27345acab211050732a5a34f2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c5a6d2bca197584a37bc9af2d98a47425b2f57ed48eae54ef45e316270e3eb7f"
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
