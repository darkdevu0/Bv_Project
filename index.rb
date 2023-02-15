class TreeNode
  attr_accessor :value, :left, :right

  def initialize(value)
	  @value = value
		@left = nil
		@right = nil
	end
end

class BST
  attr_accessor :root, :size

  def initialize()
    @root = nil
    @size = 0
	end
  
  def input_elements()
    s = gets.chomp
    array = s.split.map(&:to_i)
    puts array
    return array
  end

  def insert(value, mutlipleinput)
    if multipleinput
     array = input_elements()
     array.each do |element| @root = insert_util(element)
     end
     return
    end
    @root = insert_util(value)
  end

	def insert_util(root = self.root, value)
    if root == nil
      root = TreeNode.new(value)
    elsif root.value < value
      root.right = insert_util(root.right, value)
    else
      root.left = insert_util(root.left, value)
    end
		return root
  end

  def delete(value)
    @root = delete_util(value)
  end

  def delete_util(node = self.root, value)
    return nil if node.nil?
    if value < node.value
      node.left = delete_util(node.left, value)
    elsif value > node.value
      node.right = delete_util(node.right, value)
    else
      if node.left == nil && node.right == nil
        return nil
      elsif node.left == nil
        tempNode = node.right
        return tempNode
      elsif node.right == nil
        tempNode = node.left
        return tempNode
      end
      tempNode = find_min(node.right)
      node.value = tempNode.value
      node.right = delete_util(node.right, tempNode.value)
    end
    return node
   end


  def inorder(root = self.root)
    return nil if root.nil?
    inorder(root.left)
    puts root.value
    inorder(root.right)
  end

  def preorder(node = self.root)
		return nil if node.nil?
		puts node.value
		preorder(node.left)
		preorder(node.right)
  end

	def postorder(node = self.root)
		return nil if node.nil?
		postorder(node.left)
		postorder(node.right)
		puts node.value
	end

  def levelorder(node = self.root)
    return nil if node.nil?
    tempString = ''
    queue = [node]
    while queue.size > 0 do
      size = queue.size()
      while size > 0 do
        currNode = queue.shift()
        print currNode.value
        print ' '
        tempString += currNode.value.to_s
        tempString += "\n"
        if currNode.left
         queue.push(currNode.left)
        end
        if currNode.right
         queue.push(currNode.right)
        end
        size = size - 1
      end
      puts
    end
    return tempString
  end


	def find_max(node = self.root)
		if node == nil
			return nil
		elsif node.right == nil
			return node
		else
			return find_max(node.right)
		end
	end

	def find_min(node = self.root)
		if node == nil
			return nil
		elsif node.left == nil
			return node
		else
			return find_min(node.left)
		end
	end

	def search(node = self.root, value)
		if node == nil
			return false
		elsif node.value == value
			return true
		elsif node.value < value
			return search(node.right, value)
		else
			return search(node.left, value)
		end
	end

	
	
	def print_path(node = self.root, path = [])
		return nil  if node.nil?
    path.push(node.value)
		if node.left == nil || node.right == nil
			for i in path
				print i
        print ' '
			end
      puts
		end
    print_path(node.left, path)
    print_path(node.right, path)
    path.pop()
  end

  def load_from_file(file)
    File.foreach(file) {
      |line| self.insert(line.to_i)
    }
	end

  def save_to_file(file)
    tempString = self.levelorder()
    File.write(file, tempString) 
  end
end

node = BST.new
while true do
   puts  "1. Add Elements."
   puts  "2. Load Elements from file (Enter File Name)"
   puts  "3. Print Lagest Element."
   puts  "4. Print Smallest Element"
   puts  "5. Print InOrder"
   puts  "6. Print PostOrder"
   puts  "7. Print PreOrder"
   puts  "8. Print LevelOrder"
   puts  "9. Search a Element"
   puts  "10. Remove a Element"
   puts  "11. Print all Paths"
   puts  " Enter 'quit' to Exit"
   
   input = gets.chomp

   if input == "quit"
     node.save_to_file('fileOut.txt')
     break
   end

   input = input.to_i

   case input
   when 1
    node.insert(0, true)
   when 2
    input2 = gets.chomp
    node.load_from_file(input2)
   when 3
    puts node.find_max().value
   when 4
    puts node.find_min().value
   when 5
    node.inorder()
   when 6
    node.postorder()
   when 7
    node.preorder()
   when 8
    node.levelorder()
   when 9
    input2 = gets.chomp.to_i
    if node.search(input2)
      puts "Element Present"
    else
      puts "Element Not Present"
    end
   when 10
    input2 = gets.chomp.to_i
    node.delete(input2)
   when 11
    node.print_path()
   end
end
