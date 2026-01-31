class Ksrc < Formula
  desc "One-liner search and read for Kotlin dependency sources"
  homepage "https://github.com/respawn-app/ksrc"
  url "https://github.com/respawn-app/ksrc/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "8fb12e308775e5249b3c6b7ca888b658834ede75136f6f3ccff948b1b7a56707"
  license "Apache-2.0"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a1ae6fc6fc448c573a702a469dae4b6fe76d7b33ff3b062bf003fab5fb844a14"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "aa3f7d6901dde291e2c3e13d1861d1476317d13259ebf3517b58c59995a15021"
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
