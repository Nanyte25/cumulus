# Public: A module to be mixed in to Diff classes that have tags
module TagsDiff
  # Public: Get the diff string for tag differences
  #
  # Returns the string to display
  def tags_diff_string
    lines = ["Tags:"]
    lines << tags_to_remove.map { |k, v| "\t#{Colors.removed("#{k} => #{v}")}" }
    lines << tags_to_add.map { |k, v| "\t#{Colors.added("#{k} => #{v}")}" }
    lines.flatten.join("\n")
  end

  # Public: Get the tags that are in AWS that are not in local configuration
  #
  # Returns a hash of tags
  def tags_to_remove
    aws_tags.reject { |t, v| @local.tags.include?(t) and @local.tags[t] == v }
  end

  # Public: Get the tags that are in local configuration but not in AWS
  #
  # Returns a hash of tags
  def tags_to_add
    @local.tags.reject { |t, v| aws_tags.include?(t) and aws_tags[t] == v }
  end

  private

  # Internal: Get the tags in AWS as a hash of key to value
  #
  # Returns a hash of tags
  def aws_tags
    @aws_tags ||= Hash[@aws.tags.map { |tag| [tag.key, tag.value] }]
  end
end
