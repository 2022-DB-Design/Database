CREATE TABLE "user"
(
	user_id VARCHAR(20) NOT NULL PRIMARY KEY,
	password VARCHAR(20) NOT NULL,
    region VARCHAR(20) NOT NULL,
	REGISTER_DATE DATE NOT NULL DEFAULT CURRENT_DATE,
	NICKNAME VARCHAR(20) NOT NULL,
	DEPT VARCHAR(20) NOT NULL,
	UNIVERSITY VARCHAR(20) NOT NULL
);

CREATE TABLE "board"
(
	board_name VARCHAR(20) NOT NULL PRIMARY KEY CHECK(board_name IN('자유게시판','중고거래게시판','공지게시판','스터디게시판'))
);


CREATE TABLE "timetable"
(
	semester VARCHAR(10) NOT NULL PRIMARY KEY,
	user_id VARCHAR(20) NOT NULL UNIQUE,
	total_credit SMALLINT NOT NULL CHECK(total_credit >= 0 AND total_credit <= 24),
	CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES "user"(user_id)
);

CREATE TABLE "article"
(
	board_name VARCHAR(20) NOT NULL,
	article_id INTEGER NOT NULL,
	time_stamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	content TEXT NOT NULL,
	user_id VARCHAR(20) NOT NULL,
	likes INTEGER NOT NULL DEFAULT 0 CHECK(likes >= 0),
	PRIMARY KEY(board_name,article_id),
	CONSTRAINT fk_board FOREIGN KEY(board_name) REFERENCES "board"(board_name)
);


CREATE TABLE "comment"
(
	comment_id INTEGER NOT NULL CHECK(comment_id >=  1),
	article_id INTEGER NOT NULL CHECK(article_id >=  1),
	board_name VARCHAR(20) NOT NULL,
	time_stamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	content TEXT NOT NULL,
	user_id VARCHAR(20) NOT NULL,
	likes INTEGER NOT NULL DEFAULT 0 CHECK(likes >= 0),
	PRIMARY KEY(comment_id,article_id,board_name),
	CONSTRAINT fk_article FOREIGN KEY(article_id,board_name) REFERENCES "article"(article_id,board_name)
);

CREATE TABLE "lecture"
(
	university VARCHAR(20) NOT NULL,
	code VARCHAR(20) NOT NULL,
	dept VARCHAR(20) NOT NULL,
	teacher VARCHAR(20) NOT NULL,
	period VARCHAR(10) NOT NULL,
	credit SMALLINT NOT NULL CHECK(credit BETWEEN 1 AND 3),
	PRIMARY KEY(university,code)
);

CREATE TABLE "lecture_review"
(
	review_id INTEGER NOT NULL PRIMARY KEY,
	university VARCHAR(20) NOT NULL,
	code VARCHAR(20) NOT NULL,
	name VARCHAR(20) NOT NULL,
	time_stamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	review TEXT NOT NULL,
	CONSTRAINT fk_lecture FOREIGN KEY(university,code) REFERENCES "lecture"(university,code)
);





