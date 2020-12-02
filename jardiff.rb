class Jardiff < Formula
  desc "Diff tool for Java classes or classpaths"
  homepage "https://github.com/scala/jardiff"
  url "https://github.com/scala/jardiff/releases/download/v1.6.0/jardiff.jar" #, using => :nounzip
  sha256 "a7c068d9880711ce7684be23cff2b07e61428c9dfe70fdd644663f1347eefbd6"

  bottle :unneeded

  depends_on openjdk@11

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
