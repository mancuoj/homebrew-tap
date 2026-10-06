class Tasu < Formula
  desc "A terminal todo list that ages"
  homepage "https://github.com/mancuoj-collective/tasu"
  version "0.13.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.13.0/tasu-aarch64-apple-darwin.tar.xz"
      sha256 "45259e9138e3073f11cf371e42f1bc08302bd62e05a913a1300f0bad225fb4d0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.13.0/tasu-x86_64-apple-darwin.tar.xz"
      sha256 "7cf490bd35006182d4c66ea62cbf50edbe66170b1f1737df8b8728a68a44d76c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.13.0/tasu-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cb6e9195c32d69402696bf72570c5285a300aa4c30ea50c9667565cd05b043bf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.13.0/tasu-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "982f2e349df9f8dac034cf9b4697d7b51390439adf091271a8cf2039da55b1cc"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "tasu"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tasu"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "tasu"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tasu"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
