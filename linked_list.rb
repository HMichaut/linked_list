# Class representing a linked list
class LinkedList

  def initialize
    @content = nil
  end

  # Adds a new node containing value to the end of the list
  def append(value)
    if @content.nil?
      @content = Node.new(value)
    elsif @content.next_node.nil?
      @content.next_node = Node.new(value)
    else
      recursive_lambda = lambda do |item|
        if item.next_node.nil?
          item.next_node = Node.new(value)
        else
          recursive_lambda.call(item.next_node)
        end
      end
      recursive_lambda.call(@content.next_node)
    end
  end

  # Adds a new node containing value to the start of the list
  def prepend(value)
    @content = if @content.nil?
                 Node.new(value)
               else
                 Node.new(value, @content)
               end
  end

  # Returns the total number of nodes in the list
  def size
    node_number = 0
    unless @content.nil?
      recursive_lambda = lambda do |item|
        node_number += 1
        recursive_lambda.call(item.next_node) unless item.next_node.nil?
      end
      recursive_lambda.call(@content)
    end
    node_number
  end

  # Returns the first node in the list
  def head
    @content.value
  end

  # Returns the last node in the list
  def tail
    if @content.nil? || @content.next_node.nil?
      @content
    else
      recursive_lambda = lambda do |item|
        if item.next_node.nil?
          item
        else
          recursive_lambda.call(item.next_node)
        end
      end
      recursive_lambda.call(@content.next_node)
    end
  end

  # Returns the node at the given index
  def at(index)
    iteration = -1
    recursive_lambda = lambda do |item|
      iteration += 1
      return 'index out of range' if item.nil?

      return item if iteration >= index

      return 'index out of range' if item.next_node.nil?

      recursive_lambda.call(item.next_node)
    end
    recursive_lambda.call(@content)
  end

  # Removes the last element from the list
  def pop
    if @content.nil?
      @content
    elsif @content.next_node.nil?
      @content = nil
    else
      recursive_lambda = lambda do |item|
        if item.next_node.next_node.nil?
          item.next_node = nil
        else
          recursive_lambda.call(item.next_node)
        end
      end
      recursive_lambda.call(@content.next_node)
    end
  end

  # Returns true if the passed in value is in the list and otherwise returns 
  # false.
  def contains?(value)
    if @content.nil?
      false
    else
      recursive_lambda = lambda do |item|
        if item.value == value
          true
        elsif item.next_node.nil?
          false
        else
          recursive_lambda.call(item.next_node)
        end
      end
      recursive_lambda.call(@content.next_node)
    end
  end

  # Returns the index of the node containing value, or nil if not found.
  def find(value)
    node_number = 0
    unless @content.nil?
      recursive_lambda = lambda do |item|
        node_number += 1
        return node_number if item.value == value

        recursive_lambda.call(item.next_node) unless item.next_node.nil?
      end
      node_number = recursive_lambda.call(@content)
    end
    node_number
  end

  # Represent your LinkedList objects as strings, so you can print them out and 
  # preview them in the console. The format should be:
  # ( value ) -> ( value ) -> ( value ) -> nil
  def to_s
    array_to_be_string = []
    if @content.nil?
      'nil'
    else
      recursive_lambda = lambda do |item|
        array_to_be_string << item.value
        recursive_lambda.call(item.next_node) unless item.next_node.nil?
      end
      recursive_lambda.call(@content)
      "( #{array_to_be_string.join(' ) -> ( ')} ) -> nil"
    end
  end

  # Inserts a new node with the provided value at the given index.
  def insert_at(value, index)
    iteration = 0
    recursive_lambda = lambda do |item|
      iteration += 1
      return nil if item.nil?

      if iteration >= index
        item.next_node = Node.new(value, item.next_node)
      else
        recursive_lambda.call(item.next_node)
      end
    end
    recursive_lambda.call(@content)
  end

  # Removes the node at the given index.
  def remove_at(index)
    iteration = 0
    recursive_lambda = lambda do |item|
      iteration += 1
      return nil if item.nil?

      if iteration >= index
        item.next_node = item.next_node.next_node
      else
        recursive_lambda.call(item.next_node)
      end
    end
    recursive_lambda.call(@content)
  end
end

# Class representing a node of a linked list
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end

  def to_s
    array_to_be_string = []
    if @value.nil?
      'nil'
    else
      recursive_lambda = lambda do |item|
        array_to_be_string << item.value
        recursive_lambda.call(item.next_node) unless item.next_node.nil?
      end
      recursive_lambda.call(self)
      "( #{array_to_be_string.join(' ) -> ( ')} ) -> nil"
    end
  end
end

new_list = LinkedList.new
# puts new_list.size
# puts new_list

new_list.append(1)
# puts new_list.size
# puts new_list

new_list.append(2)
# puts new_list.size
# puts new_list

new_list.append(3)
# puts new_list.size
# puts new_list

new_list.append(4)
# puts new_list.size
# puts new_list

new_list.prepend(0)
# puts new_list.size
# puts new_list

# puts new_list.head
# puts new_list.tail

# puts new_list.at(1)
# puts new_list.at(2)
# puts new_list.at(3)
# puts new_list.at(4)
# puts new_list.at(8)

# new_list.pop
# puts new_list.size
# puts new_list

# new_list.pop
# puts new_list.size
# puts new_list

# puts new_list.contains?(2)
# puts new_list.contains?(1)
# puts new_list.contains?(5)

# p new_list.find(2)
# p new_list.find(1)
# p new_list.find(5)

puts new_list
new_list.remove_at(3)
puts new_list
new_list.insert_at(3, 3)
puts new_list
