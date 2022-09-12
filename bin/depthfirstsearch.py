#script to practice depth first search

#DFS is conducted by visiting the left child first and then the root and then the right child recursively.
#I understand it as being left to right. 

# Definition for a binary tree node.
from typing import List
from typing import Optional
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:

    # This is the iterative solution that uses a stack and a pointer to do the inorder traversal
    # Work by first going to the left-most node, pushing to the stack any nodes we go over
    # If the point is then empty it will then pop the most recent value on the stack and check its right node
    # The right nodes left and right child are both checked and if there is nothing it will continue to pop and check for each level of the tree
    def iterativeTraversal(self, root:Optional[TreeNode]) -> List[int]:
        res =[]
        cur = root
        stack = []

        while cur or stack:
            while cur:
                stack.append(cur)
                cur.left
            cur = stack.pop()
            res.append(cur.val)
            cur = cur.right


    # Similar to the above but using recursive function calling in order to accomplish the same.
    # First an if condition for empty trees is created
    # A helper function is then created 
    # Then a condition if the root value is empty to return to the next call on the stack
    # Recursive call to move to the left child 
    # Append whatever value is at the node to the result array
    # Check the right node and repeat recursively
    # return the result array 
    def inorderTraversal(self, root:Optional[TreeNode]) -> List[int]:
        if root is None: return
        def dfs (root,res):
            if root is None: return
            dfs(root.left, res)
            res.append(root.val)
            dfs(root.right, res)
            return res
        return dfs(root,[])

#This solution specifically is for leetcode question 94 