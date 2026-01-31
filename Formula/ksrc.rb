class Ksrc < Formula
  desc "One-liner search and read for Kotlin dependency sources"
  homepage "https://github.com/respawn-app/ksrc"
  url "https://github.com/respawn-app/ksrc/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "8fb12e308775e5249b3c6b7ca888b658834ede75136f6f3ccff948b1b7a56707"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "56b696668e010c4fdf5193b544ccbd53cf1ed9fdd3de8331424afd96c304b7c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "875fcb29d8ff76a62995c67be1852465ccb2e9cf81753d6e6df2448194bd8325"
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
