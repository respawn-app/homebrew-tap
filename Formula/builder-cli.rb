class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "4ef090548128003d7cb09f9d8c1ae454ce33847de396c885880f1af5c43dad7f"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "cd8c306a528c78f50f0df31f2437fdf3c1f84c2142e6c19ea939d442f3aa6bfe"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ef5edb8190c80514495612d29d06dd853b8c6186d6b0f772c79ff3df368df9af"
  end

  depends_on "go" => :build
  depends_on "git"
  depends_on "ripgrep"

  def install
    ENV["BUILDER_VERSION"] = version.to_s
    system "bash", "scripts/build.sh", "--output", bin/"builder"
  end

  test do
    assert_match "Usage of builder:", shell_output("#{bin}/builder --help 2>&1")
  end
end
