class Cashier

  def initialize
    @subtotal = 0
    @coffee_options = {1 => 5, 2 => 7.5, 3 => 9.75}
    @item_tracker = {1 => 0, 2 => 0, 3 => 0}
    @coffees = { 1 => "Light", 2 => "Medium", 3 => "Bold"}
  end

  def validate(input)
    input =~ /\A\$?\d+(.\d{1,2})?\z/
  end

  def calculate(tendered, price)
    puts "\n===Thank You!===
    \nThe total change due is $ #{sprintf('$%0.2f', (@tendered.to_f - @subtotal.to_f))}
    \n#{Time.now}
    \n================
    \nThanks for your business!"
    exit
  end

  def validate_amount(price, tendered)
    if @tendered.to_f < @subtotal.to_f
      puts "Not enough! You still owe #{sprintf('$%0.2f', @subtotal.to_f - @tendered.to_f)}" 
      get_tendered
    else 
      calculate(@tendered, @subtotal)
    end
  end

  def show_menu
    puts "Welcome to James' Coffee Emporium!\n
    1) Add item - $5.00 - Light Bag
    2) Add item - $7.50 - Medium Bag
    3) Add item - $9.75 - Bold Bag
    4) Complete Sale\n \n"
  end

  def pick_item
    puts "What item is being purchased?\n"
    @selection = gets.chomp
    if @selection.to_i > 4 || /[a-zA-Z]/.match(@selection)
      puts "Please enter a valid number: "
      pick_item
    end
  end

  def pick_amount
    puts "How many bags?\n"
    @amount = gets.chomp
  end

  def update_tracker
    @item_tracker[@selection.to_i] += @amount.to_i
  end

  def update_subtotal
    @subtotal += ((@coffee_options[@selection.to_i]).to_f * @amount.to_i)
  end

  def report_subtotal
      puts "\nSubtotal: #{sprintf('$%0.2f', @subtotal)}"
  end

  def list_items
    puts "\n===Sale Complete===\n \n"
    @item_tracker.each do |key, value|
      if @item_tracker[key] > 0
        print "$#{@coffee_options[key] * @item_tracker[key]} - #{@item_tracker[key]} #{@coffees[key]}\n"
      end
    end
  end

  def get_tendered
    puts "What is the tendered amount?"
    @tendered = gets.chomp
    if validate(@tendered)
      validate_amount(@subtotal, @tendered)
    else
      puts "Sorry, that's not a valid amount. Please try again."
      get_tendered
    end
  end

  def ring_up
    pick_item
    while @selection != "4"
      pick_amount
      update_subtotal
      update_tracker
      report_subtotal
      pick_item
    end
    if @selection == "4"
      list_items
      report_subtotal
      get_tendered
    end
  end
end

x = Cashier.new
x.show_menu
x.ring_up
