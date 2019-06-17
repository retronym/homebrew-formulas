class Jardiff < Formula
  desc "Diff tool for Java classes or classpaths"
  homepage "https://github.com/scala/jardiff"
  url "https://github.com/scala/jardiff/releases/download/v1.3.0/jardiff.jar" #, using => :nounzip
  sha256 "41b13e6166fae00b3639c2d3f33f3ab013b1f24d021d7768b0d549a40ab61db9"

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    libexec.install "jardiff.jar"

    (bin/"jardiff").write <<~EOS
      #!/bin/sh
      java $JAVA_OPTS -jar "#{libexec}/jardiff.jar" "$@"
    EOS
  end

  test do
    assert_match "usage: jardiff", shell_output("#{bin}/jardiff -help")
  end
end
