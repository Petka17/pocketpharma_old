module DsProductsHelper

  def button_text(flag)
		flag ? ['Отклонить', 'primary'] : ['Подтвердить', 'warning']
	end

end
