class Brewtool < Formula
  desc "Terminal user interface (TUI) for Homebrew package management"
  homepage "https://github.com/marko0905/brewtool"
  url "https://github.com/marko0905/brewtool/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "8398f5e62f4a7d50966b42fc7f1f53f3f98bd417a66a08f035827585ee42246e"
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
