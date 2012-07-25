require 'csv_parser'

describe CsvParser do
  context '#initialize' do
    it 'takes an IO object and exposes it on file_input' do
      csv = CsvParser.new(StringIO.new)
      csv.file_input.should be_a(CSV)
    end
  end

  context '#create_or_update_records' do
    let(:headers) { %Q(id,geographic_area,state,region,population_estimate,facebook,fb_object_id,twitter,twitter_id,multiple_accounts\n) }
    let(:create_record_test) { headers + %q( ,create_record_test,NV,1,00000) }
    let(:other_field_tests)  { headers + %q( ,create_record_test,NV,1,00000,Y,12345,Y,54321,N) }

    before do
      FacebookPage.any_instance.stub(:enqueue_facebook_page)
    end

    it 'creates a new record when the first column is blank' do
      cp = CsvParser.new( create_record_test )
      cp.create_or_update_records
      Municipality.last.geographic_area.should eql('create_record_test')
    end

    it 'updates the existing record when the first column has an id' do
      m = Municipality.create(geographic_area: 'update_record_test')
      cp = CsvParser.new( headers + %Q(#{m.id},update_record_test,NV,1,12345) )
      cp.create_or_update_records
      Municipality.last.state.should eql('NV')
    end

    it 'sets booleans properly' do
      cp = CsvParser.new( other_field_tests )
      cp.create_or_update_records
      Municipality.last.multiple_accounts.should be_false
    end

    it 'creates a facebook page' do
      cp = CsvParser.new( other_field_tests )
      cp.create_or_update_records
      Municipality.last.facebook_page.fb_object_id.should eql(12345)
    end

    it 'creates a twitter page' do
      cp = CsvParser.new( other_field_tests )
      cp.create_or_update_records
      Municipality.last.twitter_page.twitter_id.should eql(54321)
    end
  end
end