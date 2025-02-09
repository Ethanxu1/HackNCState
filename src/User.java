import java.util.ArrayList;
import java.time.LocalDate;

public class User 
{
    private final int userId; //Hash code?
    private String name;
    private String phoneNumber;
    private final int connectionCode; // Hash code?
    public ArrayList<User> connections;
    private double loanLimit = 150.0;
    private double activeLoanAmount;
    private ArrayList<Loan> allLoans;

    public User(String name, String phoneNumber) {
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.userId = (name + "PiggyBank" + this.phoneNumber).hashCode();
        this.connectionCode = ("PiggyBank" + this.phoneNumber).hashCode();
        this.connections = new ArrayList<User>();
        this.activeLoanAmount = 0.0;
        this.allLoans = new ArrayList<Loan>();
    }

    public void calculateLoanLimit()
    {
        int numLoans = this.getAllLoans().size();
        if (numLoans > 5)
        {
            this.loanLimit = 350;
        }
        else if (numLoans != 0)
        {
            this.loanLimit = 200;
        }
        
    }

    public double getLoanLimit() {
        return this.loanLimit;
    }

    private double calculateDollarsFromLimit() {
        return this.getLoanLimit() - this.activeLoanAmount;
    }

    private int getConnectionCode(){
        return this.connectionCode;
    }

    public void addConnection(int code, User user) {
        if (user != null && !connections.contains(user))
        {
            if (code == this.getConnectionCode()) {
                this.connections.add(user);
            }
        }
        else// Produce pop up box saying not allowed
        {
            throw new IllegalArgumentException();
        }
    }

    private boolean followUser(String code)
    {
        for (User user: connections)
        {
            if (user.getConnectionCode() == Integer.parseInt(code))
            {
                return true;
            }
        }

        return false;
    }

    public ArrayList<Loan> getAllLoans() {
        return this.allLoans;
    }

    public void addAllLoans(Loan newLoan) {
        this.allLoans.add(newLoan);
    } 

    private void incrementActiveLoanAmount(double loanAmount) {
        this.activeLoanAmount += loanAmount;
    }

    public void addLoan(Loan newLoan)
    {
        allLoans.add(newLoan);
        incrementActiveLoanAmount(newLoan.getAmount());
        this.calculateLoanLimit();
    }

    public String getName()
    {
        return this.name;
    }

    public Loan requestLoan(double amount, LocalDate dueDate)
    {
        if (dueDate == null || amount <= 0 || amount > this.calculateDollarsFromLimit()) {
            throw new IllegalArgumentException("Invalid loan amount");
        }
            Loan newLoan = new Loan("L" + this.userId, amount, LocalDate.now(), dueDate);
            this.addLoan(newLoan);
            return newLoan;
    }


}
