require 'csv'

class CsvParser
  CSV::Converters[:bool] = lambda { |value| case value.downcase; when 'y' then true when 'n' then false else value end }

  attr_reader :file_input

  def initialize(input)
    @file_input = CSV(input, headers: true, header_converters: :symbol, converters: [ :integer, :bool ])
  end

  def create_or_update_records
    file_input.each do |r|
      m = r[:id].is_a?(Integer) ? Municipality.find(r[:id]) : Municipality.new
      m.set_attributes(r)
      m.save!
    end
  end
end