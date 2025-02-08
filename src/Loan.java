import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;

public class Loan{
    private static final int MAX_LOAN = 350;
    private String loanId;
    private double amount;
    private LocalDate startDate;
    private LocalDate dueDate;
    private LOAN_STATUS status;
    private double paidAmount;
    private ArrayList<String> paymentHistory;

    private String consequences;
    public enum LOAN_ASK{PENDING, APPROVED, REJECTED}
    public enum LOAN_STATUS{ACTIVE, COMPLETED, OVERDUE}
    private int activeLoans;
    

    public Loan(String loanId, double amount, LocalDate startDate, LocalDate dueDate) {
        if (amount <= 0 || amount > MAX_LOAN) {
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

    public Loan(String loanId, User lender, double amount, LocalDate dueDate) {
        if (amount <= 0 || amount > maxLoan) {
            throw new IllegalArgumentException("Invalid loan amount");
        }
        this.loanId = loanId;
        this.borrower = borrower;
        this.lender = lender;
        this.amount = amount;
        this.startDate = LocalDate.now();
        this.dueDate = LocalDate.;
        this.status = LoanStatus.PENDING;
        this.paidAmount = 0;
        this.paymentHistory = new ArrayList<>();
    }

    private int maxLoan() {
    
    }

    public long daysLeftLoan() {
        return ChronoUnit.DAYS.between(this.dueDate, LocalDate.now());
    }


    public void calculateConsequences()
    {
        // disable the user's ability to get more loans
    }

    public void updateStatus(Loan newStatus)
    {
        this.status = newStatus;
    }

    public void loanPaid()
    {
        
    }

    public void approveLoan() {
        if (status == LOAN_STATUS.PENDING) {
            status = LOAN_STATUS.APPROVED;
            this.startDate;
        }
    }

    public int getMaxLoan(){
        Ratiing rate = new Rating
        return this.maxLoan;
    }


   
}