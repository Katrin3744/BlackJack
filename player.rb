class Player < Person
  attr_reader :name
  NAME_FORMAT = /^[a-z0-9]{3,15}$/i

  def initialize(name)
    @name=name
    validate!
    super()
  end

  def validate!
    raise "Неверный формат имени" if name !~ NAME_FORMAT
  end

end
