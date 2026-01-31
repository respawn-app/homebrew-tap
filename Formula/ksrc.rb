class Ksrc < Formula
  desc "One-liner search and read for Kotlin dependency sources"
  homepage "https://github.com/respawn-app/ksrc"
  url "https://github.com/respawn-app/ksrc/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "8fb12e308775e5249b3c6b7ca888b658834ede75136f6f3ccff948b1b7a56707"
  license "Apache-2.0"
  depends_on "go" => :build
  depends_on "ripgrep"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/ksrc"
  end

  test do
    assert_match "ksrc", shell_output("#{bin}/ksrc --help")
  end
end
