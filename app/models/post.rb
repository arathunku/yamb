# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content    :text(4294967295)
#  excerpt    :text
#  title      :string(255)
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#  metadata   :text
#

# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content    :text(4294967295)
#  excerpt    :text
#  title      :string(255)
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class CaseInsensitiveHash < Hash
  def [](key)
    super(key.to_s.downcase)
  end
end
class MetadataParseError < RuntimeError; end

class Post < ActiveRecord::Base
  belongs_to :user

  before_validation :parse_content

  before_validation :fill_status
  before_validation :fill_title
  before_validation :fill_content
  before_validation :fill_excerpt
  before_validation :fill_metadata

  validates :excerpt, presence: true
  validates :status, presence: true,
                     length: {maximum: 255}
  validates :content, presence: true
  validates :title, presence: true,
                    length: {maximum: 255}
  validates :metadata, presence: true

  #TODO:
  # * add publish_at field and sort by that
  default_scope { order('created_at desc')}

  def metadata_key(key)
    unless @metadata_hash
      @metadata_hash = parse_metadata(self.metadata)
    end
    @metadata_hash[key]
  end

  def merge_content
    [self.metadata, 
     "", self.content].join("\n")
  end
  private
    def fill_excerpt
      debugger
      self.excerpt = metadata_key('excerpt') || @body.gsub('\n', "\n")
    end

    def fill_status
      self.status = metadata_key('status') || "draft"
    end

    def fill_title
      self.title = metadata_key('title') || "no title"
    end

    def fill_content
      self.content = @body || "nothing."
    end

    def fill_metadata
      self.metadata = @first_paragraph || "Status: draft"
    end

    def parse_content
      @first_paragraph, @body = self.content.split(/\r?\n\r?\n/, 2)
      @metadata_hash = parse_metadata(@first_paragraph)
    end

    def parse_metadata(first_paragraph)
      is_metadata = first_paragraph.split("\n").first =~ /^[\w ]+:/
      raise MetadataParseError unless is_metadata
      hash = CaseInsensitiveHash.new
      first_paragraph.split("\n").each do |line|
        key, value = line.split(/\s*:\s*/, 2)
        next if value.nil?
        hash[key.downcase] = value.chomp
      end
      hash
    end
end
