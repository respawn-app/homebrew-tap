class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "c6ef304dbb5e9781e3d6b54e2e7c41c6c4d46a55222829be4f031bfa3387bb67"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
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
