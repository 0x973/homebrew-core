class Invoice < Formula
  desc "Command-line invoice generator"
  homepage "https://github.com/maaslalani/invoice"
  url "https://github.com/maaslalani/invoice/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f34f20f6491f42c0e94dbde433a578f0dba98938f2e3186018d3e16d050abdaf"
  license "MIT"
  head "https://github.com/maaslalani/invoice.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    cmd = "#{bin}/invoice generate --from \"Dream, Inc.\" --to \"Imagine, Inc.\" " \
          "--item \"Rubber Duck\" --quantity 2 --rate 25 " \
          "--tax 0.13 --discount 0.15 " \
          "--note \"For debugging purposes.\""
    assert_equal "Generated invoice.pdf", shell_output(cmd).chomp
    assert_predicate testpath/"invoice.pdf", :exist?
  end
end
