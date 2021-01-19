module SearchAlgorithm
  extend ActiveSupport::Concern
  
  # This uses the dept first search Algorithm to loop though 
  # the friends of he current user, and their friends.
  # @see find_heading to seach the headings of the Members as they are visited.
  # @returns an Array of Hashes in format [{Member object, String path to introduce}]
  def dfs()
    visited = []
    results = {}
    visited << @member
    to_search = @member.friends
    while to_search.length > 0
      member = to_search.pop
      if visited.include? member
        next
      else
        results, visited = find_heading(@query, member, visited, results)
      end
    end
    return introduction_path(results)
  end

  # If a member has not been visited, add it to visited stack and 
  # then pull the headings of the member's website to see it there is a match.
  # Note, since the requirement says "are not already friends of " ecluding friends of @member here.
  # Also, the members that have no way to be introduced i.e (Not friend of friends) is excluded
  def find_heading(keyword, member, visited, results)
    unless visited.include? member
        found = member.headings.pluck(:name).select{|h| h.include?(keyword)}.first 
        visited << member
        results[member] = found if found && !@member.friends.include?(member)
        member.friends.each {|f| find_heading(keyword, f, visited, results)}
    end
    [results, visited]
  end

  # This is to fulfil the rquirement to show the relationship link,
  # in case the current member needs an introduction to them
  def introduction_path(search_results)
    path = {}
    search_results.each_pair do |key, value| 
      p = find_path(@member, key)
      path[key] = p.join(" -> ") + "(%s)" %[value]
    end
    path
  end

  # This method tracks and collect path from the current member to each posible connection they can be introduced to
  def find_path(member, goal_node)
    path = []
    paths_from_origin(member).each_pair do |k,v|
        path << k.name 
        if v.include?(goal_node)
            path << goal_node.name 
            break
        end
    end
    path
  end

  # Mimic a graph using Origin (Member) as the the starting node
  # and use breath first search to get the shortest path to each Node recursively
  def paths_from_origin(origin, breath_first_paths = {})
    visited = breath_first_paths.keys | [origin]
    have_path = breath_first_paths.map{|k,v| v}.flatten.uniq | [origin]
    nodes = (origin.friends - visited) - have_path
    have_path |= nodes
    breath_first_paths[origin] = nodes
    nodes.each{|f| paths_from_origin(f, breath_first_paths)}
    breath_first_paths
  end

end