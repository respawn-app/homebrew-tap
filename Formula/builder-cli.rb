class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "8360792c485360a780368e40342e60889e3e828cfb26beef895f334aedd54290"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "4d3a311f575e05ecd67b692eeb095741f4b27ee8e93b1903f305d158744e2af1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "adf84e1a152653cd27a1ef0b02400c93de897817b572d4052c2ca78c08dd5023"
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
