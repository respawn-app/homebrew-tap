class Ksrc < Formula
  desc "One-liner search and read for Kotlin dependency sources"
  homepage "https://github.com/respawn-app/ksrc"
  url "https://github.com/respawn-app/ksrc/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "127cb7ee92959344104f536f7a9121b0610e0385982e152dc0cca80f88b0df7c"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "74b68bd9412406d2f3f2ac62a862786b0d25b7aca02e79a117c9098330458f96"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1359a10512fbfe88a885d492de433ed540483ee4df9f8861b0a3c87b6beb3f89"
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
