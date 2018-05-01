message PropertyTypeMismatch do
  title "Type Error"

  block do
    text "The type of the default value of the"
    bold name
    text "property does not match its type annotation."
  end

  was_expecting_type expected, got

  snippet node
end
