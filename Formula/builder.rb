class Builder < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/agent"
  url "https://github.com/respawn-app/agent/archive/refs/heads/main.tar.gz"
  sha256 "079058377f8bf08f3c6f73791b7f57487f007834b6381b1f4f1b9e4a50998854"
  license "AGPL-3.0-only"
  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X builder/internal/buildinfo.Version=#{version}"), "./cmd/builder"
  end

  test do
    assert_match "Usage of builder:", shell_output("#{bin}/builder --help 2>&1")
  end
end
