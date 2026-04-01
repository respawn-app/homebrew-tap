class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.7.2.tar.gz"
  sha256 "0b7fc8bb0ceaed7e1b544882f6c962e0ac40c738738f026341f9ffd0ccfaf2b4"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c5730890bbbb03e478322514f5f6efa2f0ea35f2db352e36c518e8aa0fb4bc98"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9c40f6ccea5bb5e518d0e230bf417fcaba1128ea30e3acf7097134b9db175d6d"
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
