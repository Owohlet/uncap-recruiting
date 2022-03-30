# frozen_string_literal: true

module Uncap
  module Repayment
    module UseCases
      class BalanceRepayments
        # NOTE: This method MUTATES the repayments objects!
        def call(repayments:, date_received:, amount_received_from_payment:)
          balance_repayments!(repayments, date_received, amount_received_from_payment)
        end

        private

        def balance_repayments!(repayments, date_received, amount_received_from_payment)
          # YOUR CODE HERE
          offsetter = amount_received_from_payment
          repayments.each do |repayment|
            balance = repayment.amount_received - repayment.amount
            offsetter += balance
            if repayment.amount_received <= repayment.amount
              if offsetter >= 0
                repayment.update(amount_received: repayment.amount, date_received: date_received)
              else
                repayment.update(amount_received: repayment.amount_received + offsetter, date_received: date_received)
                break
              end
            else
              repayment.update(amount_received: repayment.amount)
            end
          end

          # excess amount left after reconciliation
          if offsetter > 0
            repayments.last.update(amount_received: repayments.last.amount_received + offsetter)
          end
          
          repayments
        end

      end
    end
  end
end
