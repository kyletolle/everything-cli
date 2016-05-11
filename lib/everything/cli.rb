# encoding: UTF-8
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require 'active_support/core_ext/string'

module Everything
  class CLI < Thor
    desc "new PIECE_NAME", "Create a new everything piece, in your current directory, with the given name, which must be in spinal-case."
    def new(piece_name)
      path = piece_path(piece_name)

      if File.exist?(path)
        puts "Piece `#{piece_name}` already exists"
        exit
      end

      piece = Everything::Piece.new(path)

      titleized_name        = piece_name.gsub('-', ' ').titleize
      markdown_header       = "# #{titleized_name}"
      default_markdown_body = <<MD
#{markdown_header}



MD
      piece.raw_markdown    = default_markdown_body


      default_yaml_metadata = <<YAML
---
public: false

YAML
      piece.raw_yaml        = default_yaml_metadata

      piece.save
    end

    map 'n' => 'new'

    desc "open_new PIECE_NAME", "Create a new everything piece, in your current directory, with the given name, which must be in spinal-case. And then open it in gvim."
    def open_new(piece_name)
      new(piece_name)
      open(piece_name)
    end
    map 'on' => 'open_new'

    desc "open PIECE_NAME", "Open the piece, in your current directory, in gvim."
    def open(piece_name)
      path = piece_path(piece_name)
      fork { `gvim -O #{path}/index.{md,yaml}` }
    end
    map 'o' => 'open'

  private

    def piece_path(piece_name)
      current_dir = Dir.pwd
      File.join(current_dir, piece_name)
    end
  end
end

