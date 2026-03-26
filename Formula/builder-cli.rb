class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "f8fc0b4b4a47302cb22c1ab594aa037d007ad288eb6fdd95e04324af53a645ef"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ebf8ab25ae86baf254bf4f21a6531e16b163043d1236b61f66294916daa5b073"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "84693c507277c0c47bea804cf160eca150913fba7e844e2e52422139b794fa55"
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
