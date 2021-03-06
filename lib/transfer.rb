class Transfer
  REJECTED_MESSAGE = "Transaction rejected. Please check your account balance."

  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if @sender.balance < @amount
      @status = 'rejected'
      return REJECTED_MESSAGE
    end

    if @status == 'pending'
      @sender.balance -= @amount
      @receiver.balance += @amount
      @status = 'complete'
    end
  end

  def reverse_transfer
    if @status == 'complete'
      @sender.balance += @amount
      @receiver.balance -= @amount
      @status = 'reversed'
    end
  end
end
