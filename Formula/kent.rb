class Kent < Formula
  desc "Minimal terminal coding agent for professional engineering workflows"
  homepage "https://github.com/respawn-llc/kent"
  url "https://github.com/respawn-llc/kent/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "9201274249c08c83b139bd8779dd3ad79981f79b575cb5d87fd6157b98490eb9"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://ghcr.io/v2/respawn-llc/tap"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d4d90fb985322d68f70db18a18f5c686538bd6756152c78e04da71425ccfe72c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2dac5e4d5e3ada3100e7ab080107cd3f9ea466bb93656749866631dd7319c55c"
  end

  depends_on "go" => :build
  depends_on "node" => :build
  depends_on "pnpm" => :build
  depends_on "ripgrep"

  def install
    ENV["KENT_VERSION"] = version.to_s
    system "bash", "scripts/build.sh", "--output", bin/"kent"
  end

  def post_install
    output = Utils.safe_popen_read(bin/"kent", "service", "restart", "--if-installed").strip
    ohai output unless output.empty?
  rescue => e
    opoo "Kent background service restart failed after update: #{e.message}"
  end

  def caveats
    <<~EOS
      Homebrew does not install the Kent server background service.

      If you want one shared background server for all Kent frontends (~70 MB RAM), run:
        kent service install
    EOS
  end

  test do
    assert_match "Usage of kent:", shell_output("#{bin}/kent --help 2>&1")
  end
end
