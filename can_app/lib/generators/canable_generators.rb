require 'rails/generators'

# taken from rails3-generators

# not sure what this does and why/if it's needed

module Canable
  module Generators
  end
end

Rails::Generators.hidden_namespaces <<
[
  "canable:model",
  "canable:user"
]

Rails::Generators.hidden_namespaces.flatten!