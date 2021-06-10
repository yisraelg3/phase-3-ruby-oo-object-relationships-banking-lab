class Transfer
  
  attr_accessor :sender, :receiver, :status, :amount
  def initialize(sender, receiver, amt)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amt
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if self.sender.balance >= self.amount && self.valid? && self.status == 'pending'
      self.receiver.deposit(self.amount)
      self.sender.balance -= self.amount
      self.status ='complete'
    else
      self.status ='rejected'
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == 'complete'
      self.sender.deposit(self.amount)
      self.receiver.balance -= self.amount
      self.status = 'reversed'
    end
  end
end
