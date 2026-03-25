class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "0f044aaddf5148277dfa79966f0d20d354dc4bd136b6880fcfa3dcea877243b4"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b685ce1332b4da1de1422532f4bf345f6df9d37599a3105692773251b7955041"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5ef078f056634dbcc0a67289ef04d971b769bed9afc9a92dc61cb4d67d7cd799"
  end

  depends_on "go" => :build
  depends_on "git"
  depends_on "ripgrep"

  def install
    system "go", "build", *std_go_args(output: bin/"builder", ldflags: "-s -w -X builder/internal/buildinfo.Version=#{version}"), "./cmd/builder"
  end

  test do
    assert_match "Usage of builder:", shell_output("#{bin}/builder --help 2>&1")
  end
end
