class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "f550f0fb37f83a1a023c8288fa5b671b5440c908991f9a38a0ac0fac3ebbbd49"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "670f895efc19d09215d147e20230ee77bdd2d7f93e828ae28d4b6814ce27d33b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4fa3c6215fb6a57d21c1f11c59245eb938d0129db694baab6653586ff7abce15"
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
