class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.10.1.tar.gz"
  sha256 "ed108d7b8c85f9f1adbd5b640ac8083001edf6063c5337369262a0f8eb0a350d"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "4b239cddaf52db90a33582253bbe63a09b6a8d367b86da15d9c6ea41ddb91b14"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a57a41f3392507ed5a6652b87ee7e4270a945e7128181ece1d3c67b672ebb579"
  end

  depends_on "go" => :build
  depends_on "git"
  depends_on "ripgrep"

  def install
    ENV["BUILDER_VERSION"] = version.to_s
    system "bash", "scripts/build.sh", "--output", bin/"builder"
  end

  test do
    assert_match "Usage of builder:", shell_output("#{bin}/builder --help 2>&1")
  end
end
