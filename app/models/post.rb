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
class MetadataParseError < RuntimeError; end
class Post < ActiveRecord::Base
  attr_accessor :metadata
  belongs_to :user
  before :parse_content

  before_validate :fill_excerpt
  before_validate :fill_status
  before_validate :fill_title
  before_validate :fill_content

  validates :excerpt, presence: true
  validates :status, presence: true,
                     length: {maximum: 255}
  validates :content, presence: true
  validates :title, presence: true,
                    length: {maximum: 255}

  #TODO:
  # * add publish_at field and sort by that
  default_scope order('created_at desc')

  def metadata(key)
    @metadata[key]
  end

  private
    def fill_excerpt
      self.excerpt = metadata('excerpt') || self.content.gsub('\n', "\n")
    end

    def fill_status
      self.status = metadata('status') || "public"
    end

    def fill_title
      self.title = metadata('title')
    end

    def fill_content
      self.content = @body || "nothing."
    end

    def parse_content
      first_paragraph, @body = self.content.split(/\r?\n\r?\n/, 2)
      @metadata = parse_metadata(first_paragraph)
    end

    def parse_metadata(first_paragraph)
      is_metadata = first_paragraph.split("\n").first =~ /^[\w ]+:/
      raise MetadataParseError unless is_metadata
      metadata = CaseInsensitiveHash.new
      first_paragraph.split("\n").each do |line|
        key, value = line.split(/\s*:\s*/, 2)
        next if value.nil?
        metadata[key.downcase] = value.chomp
      end
      metadata
    end
end
