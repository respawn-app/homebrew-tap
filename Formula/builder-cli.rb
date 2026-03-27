class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/builder"
  url "https://github.com/respawn-app/builder/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "ea7ec3fd72541776a27a195f3ff1ebea3c0a074bc503cb1b3c1a648f99516b03"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-app/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e91ed8dc35929ef2df9b4f480f06a2a97b905d1766e1d50a24f680867e780bea"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b7e0a4296f2b949b99492132f1330cf8238cc3d11a8785c85622c1aac3279964"
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
