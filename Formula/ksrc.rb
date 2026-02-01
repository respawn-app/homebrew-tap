class Ksrc < Formula
  desc "One-liner search and read for Kotlin dependency sources"
  homepage "https://github.com/respawn-app/ksrc"
  url "https://github.com/respawn-app/ksrc/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "d17e1f54162e1605e176e4a64c7dc7f317da112b508b408f4d55256d482ee830"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7b677451f52bafc94426360f0e4a136134c1133ace733ea6cb2995467244ef1d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "34278ce92023c1c7bda32857e9719be2a91269cc7e82e05b261eee5dc40be784"
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
