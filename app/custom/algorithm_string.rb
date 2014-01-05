class AlgorithmString < String

  #Find the longest common substring with the 
  #string_to_compare parameter.
  # * *Args*
  #   - +string_to_compare+ -> A string which is compared to this string instance to find the longest common substring
  # * *Returns*
  #   - A string that is the first longest common substring found. 
  def longest_common_substring(string_to_compare)
    @longest_begin = -1
    @longest_length = 0    
    unless self.length < 1 || string_to_compare.nil? || string_to_compare.length < 1
      @current_outer = 0
      while (@current_outer + @longest_length) < self.length
        @current_inner = 0
        while @current_inner < string_to_compare.length
          if self[@current_outer] == string_to_compare[@current_inner]
            process_first_character_match(string_to_compare)
            break
          end
          @current_inner = @current_inner + 1
        end
        @current_outer = @current_outer + 1
      end
    end
    self.slice(@longest_begin,@longest_length)
  end


  private

    #  Called from longest_common_substring when a first character match is found.
    #  Advances to the next character in both strings to look for a match.
    #
    #   - +string_to_compare+ -> A string which is compared to this string instance to find the longest common substring
    #
    # * *Returns*
    #   - A string that is the matching characters found. 
    def process_first_character_match(string_to_compare)
      current_begin = @current_outer
      current_length = 1
      @current_outer = @current_outer + 1
      @current_inner = @current_inner + 1
      while @current_outer < self.length && @current_inner < string_to_compare.length
        if self[@current_outer] == string_to_compare[@current_inner]
            current_length=current_length + 1
        else
          break
        end
        @current_outer = @current_outer + 1
        @current_inner = @current_inner + 1
      end      
      if current_length > @longest_length
         @longest_begin=current_begin
         @longest_length = current_length
      end      
    end
end