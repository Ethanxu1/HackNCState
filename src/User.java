import java.util.ArrayList;
import java.time.LocalDate;
import java.util.Scanner;

public class User 
{
    private final int userId; //Hash code?
    private String name;
    private String profileSection;
    private String phoneNumber;
    private final int connectionCode; // Hash code?
    public ArrayList<User> connections;
    private double loanLimit = 150.0;
    private double activeLoanAmount;
    private ArrayList<Loan> allLoans;
    private ArrayList<Loan> pendingApprovalLoans;

    public User(String name, String phoneNumber, String profileInput) {
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.profileSection = profileInput;
        this.userId = (name + "PiggyBank" + this.phoneNumber).hashCode();
        this.connectionCode = ("PiggyBank" + this.phoneNumber).hashCode();
        this.connections = new ArrayList<User>();
        this.activeLoanAmount = 0.0;
        this.allLoans = new ArrayList<Loan>();
        this.pendingApprovalLoans = new ArrayList<Loan>();
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

    public void changeProfile(int userId) {
        if (this.getUserId() != userId){
            throw new IllegalArgumentException("The user ID inputted is incorrect");
        }
        Scanner inputObject = new Scanner(System.in);
        System.out.println("Enter new profile description of your reason for requesting loan");

        String newProfileDescription = inputObject.nextLine();
        this.profileSection = newProfileDescription;

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


    private void incrementActiveLoanAmount(double loanAmount) {
        this.activeLoanAmount += loanAmount;
    }

    private void addLoan(Loan newLoan)
    {
        this.allLoans.add(newLoan);
        incrementActiveLoanAmount(newLoan.getAmount());
        this.calculateLoanLimit();
    }

    private void addPendingLoan(Loan newLoan) {
        this.pendingApprovalLoans.add(newLoan);
    }

    public String getName()
    {
        return this.name;
    }

    private int getUserId() {
        return this.userId;
    }


    public void requestLoan(double amount, LocalDate dueDate)
    {
        if (dueDate == null || amount <= 0 || amount > this.calculateDollarsFromLimit()) {
            throw new IllegalArgumentException("Invalid loan amount");
        }
        Loan newLoan = new Loan("L" + this.userId, amount, LocalDate.now(), dueDate);
        this.addPendingLoan(newLoan);
        this.changeProfile(this.userId); //Profile section doubles as reason for loan for the prototype
    }


}
