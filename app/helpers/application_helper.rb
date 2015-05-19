module ApplicationHelper
  def safe_url(url)
    if url.present?
      uri = URI.parse(url.strip)
      if %w[http https].include?(uri.scheme)
        return url.strip
      else
        uri.scheme = 'http'
        return uri.to_s
      end
    end
  end

  def tel_to(tel, *args, &block)
    groups = tel.to_s.scan(/(?:^\+)?\d+/)
    if groups.size > 1 && groups[0][0] == '+'
      # remove leading 0 in area code if this is an international number
      groups[1] = groups[1][1..-1] if groups[1][0] == '0'
      groups.delete_at(1) if groups[1].size == 0 # remove if it was only a 0
    end
    link_to "tel:#{groups.join '-'}", *args, &block
  end

  def location_url(federal_state: nil, postcode: nil)
    args = {controller: 'lists', action: 'postcode', postcode: postcode, federal_state: federal_state}
    if federal_state and postcode
      url_for(args)
    elsif postcode.nil? and federal_state
      url_for(args.merge(action: 'federal_state'))
    else
      url_for(controller: 'lists', action: 'country')
    end
  end
end
