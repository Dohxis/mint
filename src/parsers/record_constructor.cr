module Mint
  class Parser
    syntax_error RecordConstructorExpectedClosingParentheses

    def record_constructor : Ast::RecordConstructor?
      start do |start_position|
        name = start do
          value = type_id
          next unless value
          next unless char! '('
          value
        end

        next unless name

        whitespace
        arguments =
          list(
            terminator: ')',
            separator: ','
          ) { expression }

        whitespace
        char ')', RecordConstructorExpectedClosingParentheses
        whitespace

        Ast::RecordConstructor.new(
          from: start_position,
          arguments: arguments,
          to: position,
          input: data,
          name: name)
      end
    end
  end
end
