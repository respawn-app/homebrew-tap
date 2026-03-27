class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "ea7ec3fd72541776a27a195f3ff1ebea3c0a074bc503cb1b3c1a648f99516b03"
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

  test do
    assert_match "Usage of builder:", shell_output("#{bin}/builder --help 2>&1")
  end
end
