class Ksrc < Formula
  desc "One-liner search and read for Kotlin dependency sources"
  homepage "https://github.com/respawn-llc/ksrc"
  url "https://github.com/respawn-llc/ksrc/archive/refs/tags/v0.6.3.tar.gz"
  sha256 "5f4c80f603167996e35aaa3d411a15a18a5057fea2b696be4980a746857e6054"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b0dd47c20fd75831f5c69a89a6cfee682efa36cdf4b1ca8ba2265c9f568bf18e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b4fb25176fab73bb2bf5816879dbdac216125dc04182079789bb1c26d1b5beb1"
  end
  depends_on "go" => :build
  depends_on "ripgrep"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/respawn-app/ksrc/internal/cli.Version=#{version}"), "./cmd/ksrc"
  end
  test do
    assert_match "ksrc", shell_output("#{bin}/ksrc --help")
  end
end
