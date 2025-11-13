class Jardiff < Formula
  desc "Diff tool for Java classes or classpaths"
  homepage "https://github.com/scala/jardiff"
  url "https://github.com/scala/jardiff/releases/download/v1.9.2/jardiff.jar" #, using => :nounzip
  sha256 "d0605527883c7f9140aa6d8e1068edb55694ed02d05354830f0bd7e67f5052ad"

  depends_on "openjdk@11"

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
