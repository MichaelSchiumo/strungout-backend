class GuitarSerializer
  include FastJsonapi::ObjectSerializer
  attributes :guitar_type, :brand, :model, :color
end
