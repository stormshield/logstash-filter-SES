# encoding: utf-8

require 'logstash/devutils/rspec/spec_helper'
require 'logstash/filters/SES'

describe LogStash::Filters::SES do
  describe "should extract source and target extension if status is EXT-BLK" do
    let(:config) do <<-CONFIG
    filter {
      SES {
      }
    }
    CONFIG
    end

    sample(
    'status' => "EXT-BLK",
    'source' => "c:\\windows\\system32\\sndvol.exe<><><>",
    'dest' => "c:\\windows\\media\\windows ding.wav"
    ) do
      expect(subject.get("source_extension")).to eq("exe")
      expect(subject.get("target_extension")).to eq("wav")
    end
  end

  describe "should extract last extension if dot present in string" do
    let(:config) do <<-CONFIG
    filter {
      SES {
      }
    }
    CONFIG
    end

    sample(
    'status' => "EXT-BLK",
    'source' => "c:\\windows\\system.32\\sndvol.exe<><><>",
    'dest' => "c:\\windows.net\\media\\windows ding.wav"
    ) do
      expect(subject.get("source_extension")).to eq("exe")
      expect(subject.get("target_extension")).to eq("wav")
    end
  end

  describe "should do nothing if status is not EXT-BLK" do
    let(:config) do <<-CONFIG
    filter {
      SES {
      }
    }
    CONFIG
    end

    sample(
    'status' => "PROFIL-BLK",
    'source' => "HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer"
    ) do
      expect(subject.get("source_extension")).to be_nil
      expect(subject.get("target_extension")).to be_nil
    end
  end
end
