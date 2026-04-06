class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "f01526624cf6171a1fd97c96a8c686b3d952029dab9dd2a567222bad82c81a1c"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "9727699a7f6a0677c21558b7195d9c9bd4662044758abf847b3f47070492213c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dfc05bc9c0ba8e98bbe2eb724021ba89adbc16ba6c458577c62205d24a893859"
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
