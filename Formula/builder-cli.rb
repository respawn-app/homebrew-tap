class BuilderCli < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-app/agent"
  url "https://github.com/respawn-app/agent/archive/e0b51e895ceffab6d4c397e0b81a2bcb63fce818.tar.gz"
  version "0.1"
  sha256 "e23832d4d6c940befac5b9c84801ae6ed26c181c0892d9529ea1352f82d190b1"
  license "AGPL-3.0-only"
  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X builder/internal/buildinfo.Version=#{version}"), "./cmd/builder"
  end

  test do
    assert_match "Usage of builder:", shell_output("#{bin}/builder --help 2>&1")
  end
end
