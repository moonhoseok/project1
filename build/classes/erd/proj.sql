SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS day;
DROP TABLE IF EXISTS point;
DROP TABLE IF EXISTS reser;
DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS musical;




/* Create Tables */

CREATE TABLE comment
(
	msno  NOT NULL,
	id varchar(15) NOT NULL,
	ccontent varchar(200),
	cstar int,
	cdate date,
	PRIMARY KEY (msno, id)
);

drop table day
CREATE TABLE day
(
	msno INT NOT NULL,
	dmd date NOT NULL,
	time1 varchar(30) NOT NULL,
	time2 varchar(30),
	time3 varchar(30),
	PRIMARY KEY (msno, dmd)
);
select * from day

CREATE TABLE member
(
	id varchar(15) NOT NULL,
	pass varchar(20),
	name varchar(20) NOT NULL,
	tel varchar(15),
	email varchar(20),
	gender int,
	bir date,
	con varchar(200),
	regdate date,
	PRIMARY KEY (id)
);


CREATE TABLE musical
(
	msno  NOT NULL,
	mtitle varchar(15) NOT NULL,
	mage varchar(30),
	mdate varchar(50),
	mtime int,
	mcast varchar(200),
	mpd varchar(100),
	mpos varchar(200),
	PRIMARY KEY (msno)
);

select * from musical

CREATE TABLE point
(
	id varchar(15) NOT NULL,
	seq  NOT NULL,
	point int,
	PRIMARY KEY (id, seq)
);


CREATE TABLE reser
(
	rno int NOT NULL,
	id varchar(15) NOT NULL,
	rtitle varchar(20),
	rmd date,
	rtime time,
	rdate date,
	rtprice int,
	rseat1 varchar(10),
	rseat2 varchar(10),
	rseat3 varchar(10),
	PRIMARY KEY (rno)
);



/* Create Foreign Keys */

ALTER TABLE comment
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE point
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE reser
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE comment
	ADD FOREIGN KEY (msno)
	REFERENCES musical (msno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE day
	ADD FOREIGN KEY (msno)
	REFERENCES musical (msno)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



