import java.time.Duration;

public class Music {

    private String name;
    private String singer;
    private boolean isPaused;
    private boolean isLiked;
    private boolean isShuffled;
    private boolean isRepeated;
    private int likes;
    private Duration duration;
    private Duration currentPosition;
    private String filePath;


    public Music(String name, String singer, Duration duration, String filePath) {
        this.name = name;
        this.singer = singer;
        this.duration = duration;
        this.filePath = filePath;
        this.isPaused = true;
        this.isLiked = false;
        this.isShuffled = false;
        this.isRepeated = false;
        this.likes = 0;
        this.currentPosition = Duration.ZERO;
    }

    public String getName() {
        return name;
    }

    public String getSinger() {
        return singer;
    }

    public boolean isPaused() {
        return isPaused;
    }

    public boolean isLiked() {
        return isLiked;
    }

    public boolean isShuffled() {
        return isShuffled;
    }

    public boolean isRepeated() {
        return isRepeated;
    }

    public Duration getDuration() {
        return duration;
    }

    public Duration getCurrentPosition() {
        return currentPosition;
    }

    public int getLikes() {
        return likes;
    }

    public String getFilePath() {
        return filePath;
    }


    public void play() {
        isPaused = false;
    }

    public void pause() {
        isPaused = true;
    }

    public void like() {
        if (!isLiked) {
            likes++;
            isLiked = true;
        }
    }

    public void unlike() {
        if (isLiked && likes > 0) {
            likes--;
            isLiked = false;
        }
    }

    public void toggleRepeat() {
        isRepeated = !isRepeated;
    }

    public void toggleShuffle() {
        isShuffled = !isShuffled;
    }

    public void forward(Duration step) {
        currentPosition = currentPosition.plus(step);
        if (currentPosition.compareTo(duration) > 0) {
            currentPosition = duration;
        }
    }

    public void rewind(Duration step) {
        currentPosition = currentPosition.minus(step);
        if (currentPosition.isNegative()) {
            currentPosition = Duration.ZERO;
        }
    }

    public String getFormattedPosition() {
        long minutes = currentPosition.toMinutes();
        long seconds = currentPosition.minusMinutes(minutes).getSeconds();
        return String.format("%02d:%02d", minutes, seconds);
    }

    public String getFormattedDuration() {
        long minutes = duration.toMinutes();
        long seconds = duration.minusMinutes(minutes).getSeconds();
        return String.format("%02d:%02d", minutes, seconds);
    }

    public double getProgressPercent() {
        if (duration.isZero()) return 0;
        return (double) currentPosition.toMillis() / duration.toMillis() * 100;
    }
}
