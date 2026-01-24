class Ksrc < Formula
  desc "One-liner search and read for Kotlin dependency sources"
  homepage "https://github.com/respawn-app/ksrc"
  url "https://github.com/respawn-app/ksrc/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "80a081b2267a08b85c9a2bd01ca77f69a51399990a06e314ec917bb1eda57773"
  license "AGPL-3.0-only"
  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "62f87d222eb2222068613c80f84ed8f04e889c53e34fc82824446b8e5db34d6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "673add76551685ddcfdd15f625b113792f5c9d58319b2f2352b91007dfc12708"
  end

  depends_on "go" => :build
  depends_on "ripgrep"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/ksrc"
  end

  test do
    assert_match "ksrc", shell_output("#{bin}/ksrc --help")
  end
end
