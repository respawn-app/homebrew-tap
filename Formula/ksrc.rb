class Ksrc < Formula
  desc "One-liner search and read for Kotlin dependency sources"
  homepage "https://github.com/respawn-app/ksrc"
  url "https://github.com/respawn-app/ksrc/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "8fb12e308775e5249b3c6b7ca888b658834ede75136f6f3ccff948b1b7a56707"
  license "Apache-2.0"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "f2b155a1f93547526f2c2cc67822f8129de05f3c283ed18ad64007672a0f0c9d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c1a0d8e6a76d7a8f83761909a2e57be0daf3d765fe9f99ab915f3a2b1abc952f"
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
