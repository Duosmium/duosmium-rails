class Result < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :data, presence: true
  # validates :card, presence: true

  before_save :gen_card

  def gen_card
    rc = ResultsController.new
    self.card = rc.render_to_string :template => 'results/_card', :locals => {:i => SciolyFF::Interpreter.new(self.data), :filename => self.name}
  end
end
