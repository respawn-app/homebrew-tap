class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "5de813d935c58be26adf428088a494fcf0f6cc3733a815fcd6579c0a2e07e3b9"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "0bd7bdaf829d818406dc4a4c3145bd4c0ace994b80a869e162d7b2fa2bd3c9ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "894eb5fa57a59d908b16aa56614c7f1bf1577a7baeb7715a038ec95145e56659"
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
