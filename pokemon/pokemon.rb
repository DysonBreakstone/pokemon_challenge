class Pokemon
  STATUS_ATTRIBUTES = {
    "sleep"=>{
      strength: 3,
      duration: 7,
      type: :regular
    },
    "paralyze"=>{
      strength: 2,
      duration: 4,
      type: :regular
    },
    "confusion"=>{
      strength: 1,
      duration: 10,
      type: :regular
    },
    "poison"=>{
      duration: 6,
      type: :special,
      strength: 0
    },
    "burn"=>{
      duration: 3,
      type: :temperature,
      strength: 5
    },
    "freeze"=>{
      duration: 2,
      type: :temperature,
      strength: 5
    }
  }

  def initialize(name:)
    @status = Hash.new { |h,v| h[v] = {regular: nil, temperature: nil, special: nil} }
    @fainted = nil
  end

  def apply(effect_name, round_to_apply_effect)
    if effect_name == "faint"
      @fainted = round_to_apply_effect
      return
    end

    status_type = STATUS_ATTRIBUTES[effect_name][:type]

    for i in round_to_apply_effect..(round_to_apply_effect + STATUS_ATTRIBUTES[effect_name][:duration] - 1)
      @status[i][status_type] = effect_name unless @status[i][status_type] && STATUS_ATTRIBUTES[@status[i][status_type]][:strength] > STATUS_ATTRIBUTES[effect_name][:strength]
    end
  end

  def status_at(round)
    return "faint" if @fainted && round >= @fainted

    statuses = @status[round].values.compact

    if statuses.include?("freeze")
      return "freeze"
    else
      statuses.size < 2 ? statuses.first : statuses
    end
  end
end