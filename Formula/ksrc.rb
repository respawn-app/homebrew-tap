class Ksrc < Formula
  desc "One-liner search and read for Kotlin dependency sources"
  homepage "https://github.com/respawn-app/ksrc"
  url "https://github.com/respawn-app/ksrc/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "d17e1f54162e1605e176e4a64c7dc7f317da112b508b408f4d55256d482ee830"
  license "Apache-2.0"
  revision 1
  test do
    assert_match "ksrc", shell_output("#{bin}/ksrc --help")
  end
end
