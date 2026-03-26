class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "0f044aaddf5148277dfa79966f0d20d354dc4bd136b6880fcfa3dcea877243b4"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "429dba642e1a16c3a6e1da021ab1019c41090d4f3dd4b48fb2d6cc76612a75bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "64e4a6834878caa941a2099d1ddbea6e88cb2b3aaa75cfd64f789c9c5c0bae3e"
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
