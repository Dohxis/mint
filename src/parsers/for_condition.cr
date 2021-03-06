module Mint
  class Parser
    syntax_error ForConditionExpectedOpeningBracket
    syntax_error ForConditionExpectedClosingBracket
    syntax_error ForConditionExpectedBody

    def for_condition : Ast::ForCondition?
      start do |start_position|
        next unless keyword "when"

        head_comments, condition, tail_comments =
          block_with_comments(
            opening_bracket: ForConditionExpectedOpeningBracket,
            closing_bracket: ForConditionExpectedClosingBracket
          ) do
            expression! ForConditionExpectedBody
          end

        self << Ast::ForCondition.new(
          head_comments: head_comments,
          tail_comments: tail_comments,
          condition: condition,
          from: start_position,
          to: position,
          input: data)
      end
    end
  end
end
