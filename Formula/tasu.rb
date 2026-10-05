class Tasu < Formula
  desc "A terminal todo list that ages"
  homepage "https://github.com/mancuoj-collective/tasu"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.11.0/tasu-aarch64-apple-darwin.tar.xz"
      sha256 "35ceea6a856252e26e3cd52e123836f984a35db6d97efc587cc62dad1c4575f9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.11.0/tasu-x86_64-apple-darwin.tar.xz"
      sha256 "e2bc6557561327c30f4d736c6683867e38c23d7c6195a0b34df6ba7ebfa85054"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.11.0/tasu-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3d83bb56ee7c93fb8940289b47b06c2eea9d04bb13e523b7fe151707c92c0f21"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mancuoj-collective/tasu/releases/download/v0.11.0/tasu-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "067feb88459a5faf047c69898c5dd6153bc7c34113cb97f99c52c1b47796d49c"
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
