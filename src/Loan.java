import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;

public class Loan{
    private String loanId;
    private double amount;
    private LocalDate startDate = LocalDate.now();
    private LocalDate dueDate;
    private LOAN_STATUS status;
    private double paidAmount;
    private ArrayList<String> paymentHistory;

    private String consequences;
    public enum LOAN_STATUS {PENDING, APPROVED, REJECTED, ACTIVE, COMPLETED, OVERDUE}
    private int activeLoans;
    

    public Loan(int maxLoan, String loanId, double amount, LocalDate startDate, LocalDate dueDate) {
        if (amount <= 0 || amount > maxLoan) {
            throw new IllegalArgumentException("Invalid loan amount");
        }
        this.loanId = loanId;
        this.amount = amount;
        this.startDate = startDate;
        this.dueDate = dueDate; //How do users approve loan requests and include due dates?
        this.status = LOAN_STATUS.PENDING;
        this.paidAmount = 0;
        this.paymentHistory = new ArrayList<String>();
    }


    public long daysLeftLoan() {
        return ChronoUnit.DAYS.between(this.dueDate, LocalDate.now());
    }


    public void calculateConsequences()
    {
        // disable the user's ability to get more loans
    }

    public void updateStatus(LOAN_STATUS newStatus)
    {
        this.status = newStatus;
    }

    public void loanPaid(double paymentAmount)
    {
        if (paymentAmount <= 0)
        {
            throw new IllegalArgumentException("Invalid payment amount");
        }
        this.paidAmount += paymentAmount;
        paymentHistory.add("" + paymentAmount);

        if (this.paidAmount >= this.amount)
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
        return this.paidAmount;
    }

    public ArrayList<String> getPaymentHistory()
    {
        return this.paymentHistory;
    }

    

    

    public int getMaxLoan(){
        Ratiing rate = new Rating
        return this.maxLoan;
    }


   
}