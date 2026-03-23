class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.1.tar.gz"
  version "0.1"
  sha256 "11568805f12769284e2e39261d2cbbb9c96397cd81c12951991bb5781d6d0837"
  license "AGPL-3.0-only"
  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X builder/internal/buildinfo.Version=#{version}"), "./cmd/builder"
  end

  test do
    assert_match "Usage of builder:", shell_output("#{bin}/builder --help 2>&1")
  end
end
