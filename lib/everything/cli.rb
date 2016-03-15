require 'rubygems'
require 'bundler/setup'

require 'thor'
require 'fileutils'

require 'active_support'
require 'active_support/core_ext/string'

module Everything
  class CLI < Thor
    desc "new PIECE_NAME", "Create a new everything piece, in your current directory, with the given name, which must be in spinal-case."
    def new(piece_name)
      piece_path_to_create = piece_path(piece_name)
      Dir.mkdir(piece_path_to_create)

      content_file      = 'index.md'
      content_file_path = File.join(piece_path_to_create, content_file)
      FileUtils.touch(content_file_path)

      titleized_name = piece_name.gsub('-', ' ').titleize
      markdown_header = "# #{titleized_name}"

      default_markdown_body = <<MD
#{markdown_header}



MD

      File.write(content_file_path, default_markdown_body)

      metadata_file      = 'index.yaml'
      metadata_file_path = File.join(piece_path_to_create, metadata_file)
      FileUtils.touch(metadata_file_path)

      default_yaml_metadata = <<YAML
---
public: false

YAML

      File.write(metadata_file_path, default_yaml_metadata)
    end

    map n: :new

    desc "open_new PIECE_NAME", "Create a new everything piece, in your current directory, with the given name, which must be in spinal-case. And then open it in gvim."
    def open_new(piece_name)
      new(piece_name)
      open(piece_name)
    end
    map on: :open_new

    desc "open PIECE_NAME", "Open the piece, in your current directory, in gvim."
    def open(piece_name)
      path = piece_path(piece_name)
      fork { `gvim -O #{path}/index.{md,yaml}` }
    end
    map o: :open

  private

    def piece_path(piece_name)
      current_dir = Dir.pwd
      File.join(current_dir, piece_name)
    end
  end
end

