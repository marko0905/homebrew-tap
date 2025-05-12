class Brewtool < Formula
  desc "Terminal user interface (TUI) for Homebrew package management"
  homepage "https://github.com/marko0905/brewtool"
  url "https://github.com/marko0905/brewtool/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f6843cca24cdb73219edbbca061e26d503ac72cae31942202719bdb624e7e3de"
  license "MIT"

  depends_on "bun"
  depends_on "node"

  def install
    # Install dependencies
    system "bun", "install"
    
    # Create bin directory and executable script
    bin.mkpath
    (bin/"brewtool").write <<~EOS
      #!/bin/bash
      cd "#{libexec}" && exec bun run start "$@"
    EOS
    
    # Make the script executable
    chmod 0755, bin/"brewtool"
    
    # Install files to libexec
    libexec.install Dir["*"]
  end

  test do
    system "#{bin}/brewtool", "--version" rescue assert_match "BrewTool", $!.message
  end
end
