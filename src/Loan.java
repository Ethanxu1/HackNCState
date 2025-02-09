import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;

public class Loan{
    private String loanId;
    private double amount;
    private LocalDate startDate = LocalDate.now();
    private LocalDate dueDate;
    private LOAN_STATUS status;
    private double amountToPay;
    private ArrayList<String> paymentHistory;
    public enum LOAN_STATUS {PENDING, APPROVED, REJECTED, ACTIVE, COMPLETED, OVERDUE}
    private int activeLoans;
    

    public Loan(String loanId, double amount, LocalDate startDate, LocalDate dueDate) {
        if ((ChronoUnit.DAYS.between(this.dueDate, LocalDate.now()) <= 0) || (ChronoUnit.DAYS.between(this.dueDate, LocalDate.now()) > 366)) {
            throw new IllegalArgumentException("Deadline for loan repayment is not within the acceptable range of 0-366 days");
        }
        this.loanId = loanId;
        this.amount = amount;
        this.startDate = startDate;
        this.dueDate = dueDate; //How do users approve loan requests and include due dates?
        this.status = LOAN_STATUS.PENDING;
        this.amountToPay = amount;
        this.paymentHistory = new ArrayList<String>();
    }


    public long daysLeftLoan() {
        return ChronoUnit.DAYS.between(this.dueDate, LocalDate.now());
    }


    public void updateStatus(LOAN_STATUS newStatus)
    {
        this.status = newStatus;
    }

    public void loanPaid(double paymentAmount)
    {
        if (paymentAmount <= 0) {
            throw new IllegalArgumentException("Invalid payment amount, must be greater than $0");
        }
        else if (paymentAmount > this.getAmountToPay()) {
            throw new IllegalArgumentException("Invalid payment amount, cannot pay more money than the total loan amount");
        }

        this.amountToPay -= paymentAmount;
        paymentHistory.add("" + paymentAmount);
        if (this.getPaidAmount() == this.getAmount())
        {
            this.status = LOAN_STATUS.COMPLETED;
        }
        
    }


    public void approveLoan() {
        if (this.status == LOAN_STATUS.PENDING) {
            status = LOAN_STATUS.APPROVED;
            this.startDate = LocalDate.now();
        }
    }

    public String getLoanId()
    {
        return this.loanId;
    }

    public double getAmount()
    {
        return this.amount;
    }

    public LocalDate getDueDate()
    {
        return this.dueDate;
    }

    public double getPaidAmount()
    {
        return this.getAmount() - this.getAmountToPay();
    }

    public double getAmountToPay()
    {
        return this.amountToPay;
    }

    public ArrayList<String> getPaymentHistory()
    {
        return this.paymentHistory;
    }

}