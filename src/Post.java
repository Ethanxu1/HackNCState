import java.util.Date;

public class Post {
    private static int postID;
    private Comment comment;
    private Date date; 
    
    public Post(String comment) {
        addComment(comment);
        date = new Date();
        postID++; 
        
    }

    public void addComment(String comment) {
        this.comment = new Comment(comment);
    }
}

