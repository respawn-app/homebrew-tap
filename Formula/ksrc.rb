class Ksrc < Formula
  desc "One-liner search and read for Kotlin dependency sources"
  homepage "https://github.com/respawn-app/ksrc"
  url "https://github.com/respawn-app/ksrc/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "39550204b30aee7c95908c60002852bbedd3eb40b6b9585b67fb2cc2f4665a91"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "617a4ccad3d480d82b4f260d9e3cc343db811bb211357c4de6fc613388914d64"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "00cc8e6f6523b8066cd816266ebd81b87f841b0a4efb4b2efc0fc737d38c5c21"
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
