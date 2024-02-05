class Asmfmt < Formula
  desc "Go Assembler Formatter"
  homepage "https://github.com/klauspost/asmfmt"
  url "https://github.com/klauspost/asmfmt/archive/refs/tags/v1.3.2.tar.gz"
  sha256 "4bb6931aefcf105c0e0bc6d239845f6350aceba5b2b76e84c961ba8d100f8fc6"
  license "MIT"
  head "https://github.com/klauspost/asmfmt.git", branch: "master"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/asmfmt"
  end

  test do
    input = "  TEXT ·subVV(SB), NOSPLIT, $0\n// func subVV(z, x, y []Word) (c Word)"
    expected = "TEXT ·subVV(SB), NOSPLIT, $0\n\t// func subVV(z, x, y []Word) (c Word)\n"
    assert_equal expected, pipe_output(bin/"asmfmt", input)
  end
end
