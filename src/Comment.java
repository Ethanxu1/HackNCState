public class Comment {
    private String content;
    private static int commentID;

    public Comment(String content) {
        setContent(content);
        commentID++; 
    }

    public int getCommentID() {
        return commentID;
    }

    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        if (content.length() < 200 && content.length() > 0) {
            this.content = content;
        }
    }
}