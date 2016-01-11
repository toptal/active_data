module ActiveData
  module Model
    module Attributes
      class ReferenceOne < Base
        def write value
          pollute do
            association.reset if value != type_casted_value
            write_value value
          end
        end

        def read
          if association.target
            association.identify
          else
            type_casted_value
          end
        end

        def read_before_type_cast
          @value_cache
        end

      private

        def type_casted_value
          variable_cache(:value) do
            typecast(read_before_type_cast)
          end
        end

        def association
          @association ||= owner.association(reflection.association)
        end
      end
    end
  end
end
