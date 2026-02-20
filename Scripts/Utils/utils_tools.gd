extends Node

# This function returns the first node in the tree by his class_name in StringName
# Use this by UtilsTools.find_first_of_class(get_tree().root, class_name)
func find_first_of_class(node: Node, class_name_str: StringName) -> Node:
	if node.get_class() == class_name_str:
		return node
	for child in node.get_children():
		var result:= find_first_of_class(child, class_name_str)
		if result: return result
	return null
