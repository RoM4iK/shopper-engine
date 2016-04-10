module ShopperEngine
  module CheckoutHelper
    def wizard_progress
      wizard_steps.map do |s|
        classes = 'step'
        classes += (s == step) ? ' active' : ''
        { name: s, classes: classes }
      end
    end
  end
end
