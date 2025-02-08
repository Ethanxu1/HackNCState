public class Rating {
    private int score;
    public Rating(int score) {
        setScore(score);
    }   
    
    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        if (score <= 850 && score >= 300) {
            this.score = score;
        }
    }
}
