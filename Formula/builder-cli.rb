class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "1da47725fbdf4e2520a2bd94b8c4c8667ef34035ecf84bb66c3d506889e303f5"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6b61dd5809a90e5e52a1a0a8e831e0df87e62ecde596cc47380b08a73146a825"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4fcd3daa6b9829484d53ec45760e2999cffe5561bea97da23bb1dc5ea0f0bc3e"
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
