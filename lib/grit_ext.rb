require "charlock_holmes"
require "rchardet19"
require "grit_ext/actor"
require "grit_ext/blob"
require "grit_ext/commit"
require "grit_ext/tree"
require "grit_ext/diff"
require "grit_ext/version"
require "grit_ext/submodule"
require "grit_ext/ref"
require "grit_ext/repo"
require "grit_ext/tag"

module GritExt
  extend self

  def encode!(message)
    return nil unless message.respond_to? :force_encoding
    
    # return message if message type is binary
    detect = CharlockHolmes::EncodingDetector.detect(message)
    return message.force_encoding("BINARY") if detect && detect[:type] == :binary
    
    if detect && detect[:confidence] == 100
      # encoding message to detect encoding
      message.force_encoding(detect[:encoding])
    else
      detect = CharDet.detect(message)
      message.force_encoding(detect[:encoding]) if detect.confidence > 0.6
    end

    # encode and clean the bad chars
    message.replace clean(message)
  rescue
    encoding = detect ? detect[:encoding] : "unknown"
    "--broken encoding: #{encoding}"
  end

  private
  def clean(message)
    message.encode("UTF-16BE", :undef => :replace, :invalid => :replace, :replace => "")
           .encode("UTF-8")
           .gsub("\0".encode("UTF-8"), "")
  end
end
