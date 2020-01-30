class RPNExpression
 
    # Set up the table of known operators
    Operator = Struct.new(:precedence, :associativity, :english, :ruby_operator)
    class Operator
      def left_associative?; associativity == :left; end
      def <(other)
        if left_associative? 
          precedence <= other.precedence
        else 
          precedence < other.precedence
        end
      end
    end
   
    Operators = {
      "+" => Operator.new(2, :left, "AND", "+"),
      "|" => Operator.new(2, :left, "OR", "|"),
      "^" => Operator.new(3, :left, "XOR", "^"),
    }
   
    # create a new object
    def initialize(str)
      @expression = str
      @infix_tree = nil
      @value = nil
    end
    attr_reader :expression
   
    # convert an infix expression into RPN
    def self.from_infix(expression)
      rpn_expr = []
      op_stack = []
      tokens = expression.split
      until tokens.empty?
        term = tokens.shift

        if Operators.has_key?(term)
          op2 = op_stack.last
          if Operators.has_key?(op2) and Operators[term] < Operators[op2]
            rpn_expr << op_stack.pop
          end
          op_stack << term
   
        elsif term == "("
          op_stack << term
   
        elsif term == ")"
          until op_stack.last == "("
            rpn_expr << op_stack.pop
          end
          op_stack.pop
   
        else
          rpn_expr << term
        end
      end
      until op_stack.empty?
        rpn_expr << op_stack.pop
      end
      obj = self.new(rpn_expr.join(" "))
     rpn_expr
    end
end