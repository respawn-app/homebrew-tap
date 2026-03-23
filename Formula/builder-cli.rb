class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "df023dd65ec670151cd3c86365510dcac0d7633651ac72a74079007b9a339133"
  license "AGPL-3.0-only"
  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
  end

  depends_on "git"
  depends_on "ripgrep"
  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"builder", ldflags: "-s -w -X builder/internal/buildinfo.Version=#{version}"), "./cmd/builder"
  end

  test do
    assert_match "Usage of builder:", shell_output("#{bin}/builder --help 2>&1")
  end
end
