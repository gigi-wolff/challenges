class Robot
  @@taken_robot_names = []

  def initialize
    @robot_name = generate_valid_robot_name
  end

  def name
    @robot_name
  end

  def reset
    @@taken_robot_names.delete(@robot_name)
    @robot_name = generate_valid_robot_name
  end

  private

  def generate_valid_robot_name
    loop do
      letters = ('A'..'Z').to_a.sample(2).join
      numbers = ('0'..'9').to_a.sample(3).join
      robot_name = letters + numbers
      if @@taken_robot_names.include?(robot_name)
        next
      else
        @@taken_robot_names << robot_name
        return robot_name
      end
    end
  end
end
