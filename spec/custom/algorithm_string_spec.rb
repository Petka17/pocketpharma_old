require 'spec_helper'

describe AlgorithmString do

  describe "Class" do
    it "should have method 'longest_common_substring'" do
      AlgorithmString.method_defined?(:longest_common_substring).should be_true
    end    
  end

  describe "Instance" do
    describe "Longest common substring method tests" do
      it "should return 'bcd' when ABCD.longest_common_substring(BCDE)  is called" do
        a_string= AlgorithmString.new('ABCD')
        a_string.longest_common_substring('BCDE').should == 'BCD'
      end

      it "should return 'try' when TRY.longest_common_substring(RETRY)  is called" do
        a_string= AlgorithmString.new('TRY')
        a_string.longest_common_substring('RETRY').should == 'TRY'
      end 

       it "should return 'FGH' when ABCDFGHXYZ.longest_common_substring(TSVPFGHARS)  is called" do
        a_string= AlgorithmString.new('ABCDFGHXYZ')
        a_string.longest_common_substring('TSVPFGHARS').should == 'FGH'
      end     
    end
  end
end