public class User 
{
    private final String userId; //Hash code?
    private String name;
    private int age;
    private String phoneNumber;
    private final String connectionCode; // Hash code?
    private ArrayList<User> followers;
    private ArrayList<User> following;

    public User(String name, int age, String phoneNumber){
        this.name = name;
        this.age = age;
        this.phoneNumber = phoneNumber;
        this.userId = (name + "PiggyBank" + phoneNumber.toString()).hashCode();
        this.connectionCode = ("PiggyBank" + phoneNumber.toString())hashCode();
    }

    @Override
    private int hashCode(){
        this.
    }

    public double calculateLoanLimit(){
        return double loanLimit;
    }
}
