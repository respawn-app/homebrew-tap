class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "e78ba10e008b49f8883f2d9d653ed532fa4a1576d52230068d56298527b1c8c4"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "1895bca50f7beb7ed5f36c9ddf3650a1aff564a672206861aef1df4f0b8ce8cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9161e5d35b8e028a90cf60be1aec69554e81c82315caa6f493bd22039e2e2bf0"
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
