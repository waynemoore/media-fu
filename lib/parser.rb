MATCHERS = {
  :tv_show => [
               /^([\w\-\ \.]+)s(\d+)e(\d+).*?\.(\w+)$/i,
               /^([\w\-\ \.]+?)(\d+)x(\d+).*?\.(\w+)$/i
              ],
  :movie => [
             /^([\w\-\ \.\(\)]+?)\.(\w+)$/i
            ]
}

def spacify(txt)
  txt.gsub(/[\.\-_]/, " ").strip
end

def parse(fn)
  MATCHERS.each do |type, patterns|
    patterns.each do |regex|
      match = fn.match(regex)
      next unless match
      fields = match.captures

      if type == :tv_show
        return {
          :type => type,
          :title => spacify(fields[0]),
          :season => fields[1].to_i,
          :episode => fields[2].to_i,
          :format => fields[3].downcase.to_sym
        }
      end

      if type == :movie
        return {
          :type => type,
          :title => spacify(fields[0]),
          :format => fields[1].downcase.to_sym
        }
      end
    end
  end
  nil
end
