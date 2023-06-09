require "spec"
require "colorize"
require "./spec_helper"

hint = ""

describe "./modules/default.nix" do
  it "imports all modules" do
    all_modules = Dir.children("modules")
    all_modules.delete("default.nix")
    modules = File.read("./modules/default.nix")

    all_modules.each do |current_module|
      hint = "Missing ./#{current_module} import in ./modules/default.nix."
      modules.includes?("./#{current_module}").should be_true
    end

    hint = ""
  end
end

describe "./overlays/joshuto/default.nix" do
  it "uses the latest joshuto commit" do
    check_latest_commit("kamiyaa/joshuto", branch: "main")
  end
end

describe "./overlays/rofi/default.nix" do
  it "uses the latest rofi-wayland commit" do
    check_latest_commit("lbonn/rofi", branch: "wayland")
  end
end

Spec.after_suite do
  hint.empty? || puts "✗ #{hint}".colorize(:yellow)
end
