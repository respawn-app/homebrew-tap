class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "d52aedac25244de9ff297d872a601cd2b1c9e83641fba2c9083e9c7fd16b81cf"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2b89026c5731f0e9c261f9955da8021a8caf92d0a9e939ca06678837180dbd65"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3d2133e04ead5db322407074e4a982845f0b2728acdfa6273718be513a3c64ad"
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
