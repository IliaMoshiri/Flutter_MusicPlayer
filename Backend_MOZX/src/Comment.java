import java.time.LocalDateTime;
import java.util.UUID;

public class Comment {

    private final String id;
    private int likes;
    private int dislikes;
    private String name;
    private String comment;
    private boolean isSent;
    private LocalDateTime timestamp;
    private boolean isEdited;

    public Comment(String name, String comment) {
        this.id = UUID.randomUUID().toString();
        this.name = name;
        this.comment = comment;
        this.likes = 0;
        this.dislikes = 0;
        this.isSent = true;
        this.timestamp = LocalDateTime.now();
        this.isEdited = false;
    }


    public String getId() {
        return id;
    }

    public int getLikes() {
        return likes;
    }

    public void like() {
        this.likes++;
    }

    public int getDislikes() {
        return dislikes;
    }

    public void dislike() {
        this.dislikes++;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getComment() {
        return comment;
    }

    public void editComment(String newComment) {
        this.comment = newComment;
        this.isEdited = true;
        this.timestamp = LocalDateTime.now();
    }

    public boolean isSent() {
        return isSent;
    }

    public void setSent(boolean sent) {
        isSent = sent;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public boolean isEdited() {
        return isEdited;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", comment='" + comment + '\'' +
                ", likes=" + likes +
                ", dislikes=" + dislikes +
                ", timestamp=" + timestamp +
                ", edited=" + isEdited +
                '}';
    }
}
