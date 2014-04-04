require 'spec_helper'

describe Import do
  let(:good_tsv) { File.new("#{Rails.root}/spec/fixtures/files/good_input.tsv") }
  let(:bad_tsv) { File.new("#{Rails.root}/spec/fixtures/files/bad_input.tsv") }

  it { should have_attached_file(:tsv) }
  it { should validate_attachment_presence(:tsv) }
  it { should validate_attachment_content_type(:tsv).
                allowing('text/tab-separated-values', 'text/plain').
                rejecting('text/csv', 'text/comma-separated-values', 'text/xml') }

  describe "#process" do
    context "with a good tsv" do
      subject { Import.create(tsv: good_tsv) }

      %w(customer merchant item sale).each do |obj|
        it "should import #{obj.pluralize}" do
          expect {
            subject.process
          }.to change(obj.capitalize.constantize, :count)
        end
      end
    end

    context "with a bad tsv" do
      subject { Import.create(tsv: bad_tsv) }

      it "should raise ActiveRecord::RecordInvalid" do
        expect {
          subject.process
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "#total" do
    subject { Import.create(tsv: good_tsv) }

    it "should calculate total gross revenue" do
      subject.process
      subject.total.should == 95
    end
  end
end
