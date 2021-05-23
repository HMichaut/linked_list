# Importing the unit test library
require "test/unit/assertions"
include Test::Unit::Assertions

# Class representing a linked list
class LinkedList

  def initialize
    @content = nil
  end

  # Adds a new node containing value to the end of the list
  def append(value)
    if @content.nil?
      @content = Node.new(value)
    else
      current_node = @content
      current_node = current_node.next_node until current_node.next_node.nil?
      current_node.next_node = Node.new(value)
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
    current_node = @content
    node_number += 1 unless current_node.nil?
    until current_node.next_node.nil?
      current_node = current_node.next_node
      node_number += 1
    end
    node_number
  end

  # Returns the first node in the list
  def head
    @content
  end

  # Returns the last node in the list
  def tail
    return nil if @content.nil? || @content.next_node.nil?

    current_node = @content
    current_node = current_node.next_node until current_node.next_node.nil?
    current_node
  end

  # Returns the node at the given index
  def at(index)
    iteration = 0
    return 'Error: Index out of range!' if size < index + 1

    current_node = @content
    while iteration < index
      current_node = current_node.next_node
      iteration += 1
    end
    current_node
  end

  # Removes the last element from the list
  def pop
    return 'Error: empty list!' if @content.nil?

    current_node = @content
    current_node = current_node.next_node until current_node.next_node.next_node.nil?
    current_node.next_node = nil
  end

  # Returns true if the passed in value is in the list and otherwise returns
  # false.
  def contains?(value)
    if @content.nil?
      false
    else
      current_node = @content
      until current_node.next_node.next_node.nil?
        current_node = current_node.next_node
        return true if current_node.value == value
      end
      false
    end
  end

  # Returns the index of the node containing value, or nil if not found.
  def find(value)
    node_number = 0
    current_node = @content
    until current_node.next_node.nil?
      return node_number if current_node.value == value

      current_node = current_node.next_node
      node_number += 1
    end
    nil
  end

  # Represent your LinkedList objects as strings, so you can print them out and
  # preview them in the console. The format should be:
  # ( value ) -> ( value ) -> ( value ) -> nil
  def to_s
    array_to_be_string = []
    return 'nil' if @content.nil?

    current_node = @content
    until current_node.next_node.nil?
      array_to_be_string << current_node.value
      current_node = current_node.next_node
    end
    array_to_be_string << current_node.value
    "( #{array_to_be_string.join(' ) -> ( ')} ) -> nil"
  end

  # Inserts a new node with the provided value at the given index.
  def insert_at(value, index)
    return 'Error: Index out of range!' if size < index

    if index == 0
      @content = Node.new(value, @content)
    else
      node_number = 1
      current_node = @content
      until node_number == index
        current_node = current_node.next_node
        node_number += 1
      end
      current_node.next_node = Node.new(value, current_node.next_node)
    end
  end

  # Removes the node at the given index.
  def remove_at(index)
    return 'Error: Index out of range!' if size < index + 1

    node_number = 1
    current_node = @content
    until node_number == index
      current_node = current_node.next_node
      node_number += 1
    end
    current_node.next_node = current_node.next_node.next_node
  end
end

# Class representing a node of a linked list
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end

  # Represent your Node objects as strings, so you can print them out and
  # preview them in the console. The format should be:
  # ( value ) -> ( value ) -> ( value ) -> nil
  def to_s
    array_to_be_string = []
    return 'nil' if self.nil?

    current_node = self
    until current_node.next_node.nil?
      array_to_be_string << current_node.value
      current_node = current_node.next_node
    end
    array_to_be_string << current_node.value
    "( #{array_to_be_string.join(' ) -> ( ')} ) -> nil"
  end
end

# Unit tests
new_list = LinkedList.new
new_list.append(1)
assert_equal new_list.size, 1
new_list.append(2)
assert_equal new_list.size, 2
new_list.append(3)
assert_equal new_list.size, 3
new_list.append(4)
assert_equal new_list.size, 4
new_list.prepend(0)
assert_equal new_list.size, 5
assert_equal new_list.to_s, '( 0 ) -> ( 1 ) -> ( 2 ) -> ( 3 ) -> ( 4 ) -> nil'
assert_equal new_list.head.to_s, '( 0 ) -> ( 1 ) -> ( 2 ) -> ( 3 ) -> ( 4 ) -> nil'
assert_equal new_list.tail.to_s, '( 4 ) -> nil'
assert_equal new_list.at(0).to_s, '( 0 ) -> ( 1 ) -> ( 2 ) -> ( 3 ) -> ( 4 ) -> nil'
assert_equal new_list.at(1).to_s, '( 1 ) -> ( 2 ) -> ( 3 ) -> ( 4 ) -> nil'
assert_equal new_list.at(2).to_s, '( 2 ) -> ( 3 ) -> ( 4 ) -> nil'
assert_equal new_list.at(3).to_s, '( 3 ) -> ( 4 ) -> nil'
assert_equal new_list.at(4).to_s, '( 4 ) -> nil'
assert_equal new_list.at(8).to_s, 'Error: Index out of range!'
new_list.pop
assert_equal new_list.size, 4
assert_equal new_list.to_s, '( 0 ) -> ( 1 ) -> ( 2 ) -> ( 3 ) -> nil'
assert_equal new_list.contains?(2), true
assert_equal new_list.contains?(1), true
assert_equal new_list.contains?(5), false
assert_equal new_list.find(2), 2
assert_equal new_list.find(1), 1
assert_equal new_list.find(5), nil
new_list.remove_at(3)
assert_equal new_list.to_s, '( 0 ) -> ( 1 ) -> ( 2 ) -> nil'
new_list.insert_at(3, 3)
assert_equal new_list.to_s, '( 0 ) -> ( 1 ) -> ( 2 ) -> ( 3 ) -> nil'
new_list.insert_at(0, 0)
assert_equal new_list.to_s, '( 0 ) -> ( 0 ) -> ( 1 ) -> ( 2 ) -> ( 3 ) -> nil'
