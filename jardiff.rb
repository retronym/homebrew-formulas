class Jardiff < Formula
  desc "Diff tool for Java classes or classpaths"
  homepage "https://github.com/scala/jardiff"
  url "https://github.com/scala/jardiff/releases/download/v1.4.0/jardiff.jar" #, using => :nounzip
  sha256 "30457e3bc6ea70705baba764ccf1c5e39e664eb9319b6c5cd389b0c32f4c95ee"

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
