cask "kent-desktop" do
  version "2.7.0"
  sha256 "d5a58706b0ae43eb1183a4788158cad12f3bddd8146b7f0815433c4b46bad535"

  url "https://github.com/respawn-llc/kent/releases/download/v#{version}/Kent_#{version}_aarch64.dmg"
  name "Kent"
  desc "Desktop client for the Kent coding agent"
  homepage "https://github.com/respawn-llc/kent"

  depends_on formula: "kent"
  depends_on macos: :sequoia
  depends_on arch: :arm64

  app "Kent.app"

  # Self-update is install-source-aware: Homebrew owns updates for cask installs
  # and locksteps with the kent formula, so the in-app updater is gated off by
  # writing the desktop settings file. Do NOT add `auto_updates true` — that would
  # make `brew upgrade` skip this cask and let the app self-update ahead of the
  # server. See docs/dev/specs/release-distribution.md.
  postflight do
    require "json"
    settings_path = File.expand_path("~/Library/Application Support/sh.kent/settings.json")
    FileUtils.mkdir_p(File.dirname(settings_path))
    data = {}
    if File.exist?(settings_path)
      begin
        parsed = JSON.parse(File.read(settings_path))
        data = parsed if parsed.is_a?(Hash)
      rescue JSON::ParserError
        data = {}
      end
    end
    data["version"] = 1
    data["selfUpdate"] = "disabled"
    File.write(settings_path, "#{JSON.pretty_generate(data)}\n")
  end

  uninstall quit: "sh.kent"

  zap trash: [
    "~/Library/Application Support/sh.kent",
    "~/Library/Caches/sh.kent",
    "~/Library/HTTPStorages/sh.kent",
    "~/Library/Saved Application State/sh.kent.savedState",
    "~/Library/WebKit/sh.kent",
  ]
end
