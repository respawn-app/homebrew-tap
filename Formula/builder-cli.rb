class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.1.tar.gz"
  sha256 "11568805f12769284e2e39261d2cbbb9c96397cd81c12951991bb5781d6d0837"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "3b3a91c7ea97eececb6a096fb970390b4c51bdea8b2c64f88809782b817e5a12"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3f71b67e846b3aa449b3ec4d61440d7fb61aa68959b49a66d69ef2959413ba6d"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"builder", ldflags: "-s -w -X builder/internal/buildinfo.Version=#{version}"), "./cmd/builder"
  end

  test do
    assert_match "Usage of builder:", shell_output("#{bin}/builder --help 2>&1")
  end
end
