# frozen_string_literal: true

require 'sqlite3'
require 'fileutils'

class Database
  DEFAULT_PATH = File.expand_path('../../../data/lost_and_found.sqlite3', __dir__)
  SCHEMA_PATH = File.expand_path('../../../db/schema.sql', __dir__)

  def self.connect(path = DEFAULT_PATH)
    FileUtils.mkdir_p(File.dirname(path)) unless path == ':memory:'

    connection = SQLite3::Database.new(path)
    connection.results_as_hash = true
    connection.execute_batch(File.read(SCHEMA_PATH))
    connection
  end
end
