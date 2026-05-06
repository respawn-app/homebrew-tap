class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "d31762fbb0af527b1e1df04876e9611d987fc0216393dbd53a155d161bd1dddd"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "1ddf97f5a081976cb647fb4274922c9a1d87e25af6bfd46c126aacea4e076c57"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "636c9ec37a98af0b533007299882e1ac95e59734e8373e9e01262e009dc6640d"
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
