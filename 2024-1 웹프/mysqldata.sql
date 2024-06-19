-- 'post' 테이블 생성
CREATE TABLE post (
    num INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    writer VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    reg_date DATETIME NOT NULL,
    pass VARCHAR(50) NOT NULL,
    view INT DEFAULT 0,
    PRIMARY KEY (num)
);

-- 'comments' 테이블 생성
CREATE TABLE comments (
    comment_id INT NOT NULL AUTO_INCREMENT,
    post_num INT NOT NULL,
    writer VARCHAR(255),
    content TEXT,
    reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    comment_pass VARCHAR(50) NOT NULL,
    PRIMARY KEY (comment_id),
    FOREIGN KEY (post_num) REFERENCES post(num) ON DELETE CASCADE
);
