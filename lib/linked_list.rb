
# Defines a node in the singly linked list
class Node
  attr_reader :data # allow external entities to read value but not write
  attr_accessor :next # allow external entities to read or write next node

  def initialize(value, next_node = nil)
    @data = value
    @next = next_node
  end
end

# Defines the singly linked list
class LinkedList
  include Enumerable
  
  def initialize
    @head = nil # keep the head private. Not accessible outside this class
  end

  def each(&block)
    return unless @head
    current = @head

    while current
      block.call(current.data)
      current = current.next
    end
  end

  # method to add a new node with the specific data value in the linked list
  # insert the new node at the beginning of the linked list
  def add_first(value)
    @head = Node.new(value, @head)
  end

  # method to find if the linked list contains a node with specified value
  # returns true if found, false otherwise
  def search(value, current=@head)
    return false if current.nil?
    return true if current.data == value
    search(value, current.next)
  end

  # method to return the max value in the linked list
  # returns the data value and not the node
  def find_max()
    self.max
  end

  # method to return the min value in the linked list
  # returns the data value and not the node
  def find_min()
    self.min
  end


  # method that returns the length of the singly linked list
  def length
    self.count
  end

  # method that returns the value at a given index in the linked list
  # index count starts at 0
  # returns nil if there are fewer nodes in the linked list than the index value
  def get_at_index(index, current=@head)
    if current.nil? || current.next.nil? || index == 0
      return current&.data
    end
    
    get_at_index(index - 1, current.next)
  end

  # method to print all the values in the linked list
  def visit
    self.map {|x| puts x}
  end

  # method to delete the first node found with specified value
  def delete(value, current=@head)
    return unless current
    return @head = @head.next if @head.data == value

    if current.next.data == value
      current.next = current.next.next
      return
    end

    delete(value, current.next)
  end

  # method to reverse the singly linked list
  # note: the nodes should be moved and not just the values in the nodes
  def reverse(x=nil, y=@head)
    unless y.next
      y.next = x
      return @head = y
    end
    ahead = y.next
    y.next = x
    reverse(y, ahead) 
  end


  ## Advanced Exercises
  # returns the value at the middle element in the singly linked list
  def find_middle_value
    raise NotImplementedError
  end

  # find the nth node from the end and return its value
  # assume indexing starts at 0 while counting to n
  def find_nth_from_end(n)
    # lead, nth = @head

    # n.times { lead = lead.next if lead }
    
    # while lead && lead.next && nth && nth.next
    #   lead = lead.next
    #   nth = nth.next
    # end

    # return nth&.data
    n = self.count.pred - n
    return if n < 0
    self.entries[n]
  end

  # checks if the linked list has a cycle. A cycle exists if any node in the
  # linked list links to a node already visited.
  # returns true if a cycle is found, false otherwise.
  def has_cycle
    raise NotImplementedError
  end


  # Additional Exercises 
  # returns the value in the first node
  # returns nil if the list is empty
  def get_first
    @head&.data
  end

  # method that inserts a given value as a new last node in the linked list
  def add_last(value)
    return @head = Node.new(value) unless @head
    
    last = @head
    last = last.next while last.next
    last.next = Node.new(value)
  end

  # method that returns the value of the last node in the linked list
  # returns nil if the linked list is empty
  def get_last
    return unless @head
    
    last = @head
    last = last.next until last.next.nil?
    last.data
  end

  # method to insert a new node with specific data value, assuming the linked
  # list is sorted in ascending order
  def insert_ascending(value)
    raise NotImplementedError
  end

  # Helper method for tests
  # Creates a cycle in the linked list for testing purposes
  # Assumes the linked list has at least one node
  def create_cycle
    return if @head == nil # don't do anything if the linked list is empty

    # navigate to last node
    current = @head
    while current.next != nil
        current = current.next
    end

    current.next = @head # make the last node link to first node
  end
end
