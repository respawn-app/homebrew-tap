class Ksrc < Formula
  desc "One-liner search and read for Kotlin dependency sources"
  homepage "https://github.com/respawn-app/ksrc"
  url "https://github.com/respawn-app/ksrc/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "db8f329cae14071507c7dd57d52d4615624413302c2870f6758b7afee7d2ae5f"
  license "AGPL-3.0-only"

  depends_on "go" => :build
  depends_on "ripgrep"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/ksrc"
  end

  test do
    assert_match "ksrc", shell_output("#{bin}/ksrc --help")
  end
end
