class Tasu < Formula
  desc "A terminal todo list that ages"
  homepage "https://github.com/mancuoj-collective/tasu"
  url "https://github.com/mancuoj-collective/tasu/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "34ad7bc85a8018efffe32d454e3d1b73ec88c937635495bf8d442de314caae4e"
  license "Apache-2.0"
  head "https://github.com/mancuoj-collective/tasu.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "tasu", shell_output("#{bin}/tasu --version")
  end
end
