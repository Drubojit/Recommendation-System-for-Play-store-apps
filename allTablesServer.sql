clear screen;

drop table CategoryServer;
drop table APPSSERVER;
	
create table CategoryServer(id number, categoryName varchar2(30),PRIMARY KEY(id));

insert into  CategoryServer values(1,'Art and Design');
insert into  CategoryServer values(2,'Books and Reference');
insert into  CategoryServer values(3,'Communication');
insert into  CategoryServer values(4,'Education');
insert into  CategoryServer values(5,'Entertainment');


CREATE TABLE APPSSERVER(appId NUMBER,appName varchar2(30),appCategory varchar2(30),appSize_MB Number,totalDownloads_M Number,freeOrPremium Number,purchasePrice NUMBER,rating Number,
PRIMARY KEY(appId));

INSERT INTO APPSSERVER VALUES(1,'Infinite Painter','Art and Design',48,10,0,0,4);
INSERT INTO APPSSERVER VALUES(2,'Adobe Photoshop Sketch','Art and Design',64,50,0,0,4.1);
INSERT INTO APPSSERVER VALUES(3,'Canava Graphic Design','Art and Design',27,100,0,0,4.6);
INSERT INTO APPSSERVER VALUES(4,'Unfold-Story Maker','Art and Design',142,10,0,0,4.5);


INSERT INTO APPSSERVER VALUES(5,'Puthika','Books and Reference',15,0.01,0,0,4.7);
INSERT INTO APPSSERVER VALUES(6,'Moon+Reader','Books and Reference',20,10,0,0,4.3);
INSERT INTO APPSSERVER VALUES(7,'Lithium EPUB Reader','Books and Reference',6,1,0,0,4.5);
INSERT INTO APPSSERVER VALUES(8,'English to Bangla Dictionary','Books and Reference',34,10,0,0,4.5);


INSERT INTO APPSSERVER VALUES(9,'WhatsApp','Communication',27,5000,0,0,4.2);
INSERT INTO APPSSERVER VALUES(10,'Imo','Communication',30,10,0,0,4.0);
INSERT INTO APPSSERVER VALUES(11,'CryptoTab Browser','Communication',45,0.1,1,200,4.0);
INSERT INTO APPSSERVER VALUES(12,'FolderSyncPro','Communication',13,0.1,1,420,4.4);

INSERT INTO APPSSERVER VALUES(13,'Microsoft Math Solver','Education',28,10,0,0,4.5);
INSERT INTO APPSSERVER VALUES(14,'Desmos graphing calculator','Education',3.2,1,0,0,4.6);
INSERT INTO APPSSERVER VALUES(15,'Moodle','Education',17,10,0,0,3.5);
INSERT INTO APPSSERVER VALUES(16,'Edmodo','Education',68,10,0,0,3.7);


INSERT INTO APPSSERVER VALUES(17,'SketchBook','Entertainment',81,50,0,0,4.2);
INSERT INTO APPSSERVER VALUES(18,'Iflix','Entertainment',19,50,0,0,4.1);
INSERT INTO APPSSERVER VALUES(19,'Meme Generator','Entertainment',64,10,0,0,4.6);
INSERT INTO APPSSERVER VALUES(20,'Vidio','Entertainment',17,10,0,0,4.3);



INSERT INTO APPSSERVER VALUES(21,'PatientAid','Health and Fitness',22,0.1,0,0,4.5);
INSERT INTO APPSSERVER VALUES(22,'Strava','Health and Fitness',28,10,0,0,4.4);
INSERT INTO APPSSERVER VALUES(23,'Hello Haylou','Health and Fitness',6.5,0.1,0,0,4.3);
INSERT INTO APPSSERVER VALUES(24,'Huawei Health','Health and Fitness',68,100,0,0,4.3);


INSERT INTO APPSSERVER VALUES(25,'Waze','Maps and Navigation',79,100,0,0,4.4);
INSERT INTO APPSSERVER VALUES(26,'Here WeGO','Maps and Navigation',38,10,0,0,4.3);
INSERT INTO APPSSERVER VALUES(27,'GPS speedometer','Maps and Navigation',5.8,1,0,0,4.5);
INSERT INTO APPSSERVER VALUES(28,'UTP Geo Map','Maps and Navigation',5.5,1,0,0,4.6);



INSERT INTO APPSSERVER VALUES(29,'OTO Music','Music and Audio',5,0.01,0,0,4.7);
INSERT INTO APPSSERVER VALUES(30,'Dolby ON','Music and Audio',50,1,0,0,4.3);
INSERT INTO APPSSERVER VALUES(31,'Music Player MP3','Music and Audio',8.6,1,0,0,4.3);
INSERT INTO APPSSERVER VALUES(32,'Free Music Downloader','Music and Audio',8.3,1,0,0,4.7);


INSERT INTO APPSSERVER VALUES(33,'Facebook Lite','Social',1.6,1000,0,0,4.2);
INSERT INTO APPSSERVER VALUES(34,'Snapchat','Social',60,1000,0,0,4.3);
INSERT INTO APPSSERVER VALUES(35,'Instagram','Social',35,1000,0,0,4.4);
INSERT INTO APPSSERVER VALUES(36,'Twitter','Social',26,1000,0,0,4.3);


INSERT INTO APPSSERVER VALUES(37,'VN Video Editor','Video Players and Editors',92,10,0,0,4.6);
INSERT INTO APPSSERVER VALUES(38,'CapCut','Video Players and Editors',48,100,0,0,4.5);
INSERT INTO APPSSERVER VALUES(39,'AZ Screen Recorder','Video Players and Editors',18,50,0,0,4.5);
INSERT INTO APPSSERVER VALUES(40,'Cast to TV','Video Players and Editors',8.7,10,0,0,4.6);


drop table RatingUpdateTrackServer;
create table RatingUpdateTrackServer(appid number,appname varchar2(30),oldRating number); 
insert into RatingUpdateTrackServer values(12,'FolderSyncPro',4.4);
insert into RatingUpdateTrackServer values(68,'ProMap Cordinates',4.5);
insert into RatingUpdateTrackServer values(61,'Home Workouts Gym',4.4);




drop table ReviewUpdateTrackServer;
create table ReviewUpdateTrackServer(appid number,appname varchar2(30),review varchar2(30),reviewrating varchar(14)); 
insert into ReviewUpdateTrackServer values(12,'FolderSyncPro','Nice ','**');
insert into ReviewUpdateTrackServer values(49,'Conversations','Good','**');
insert into ReviewUpdateTrackServer values(4,'Unfold-Story Maker','Excellent ','***');
insert into ReviewUpdateTrackServer values(17,'SketchBook','Bad','*');


commit;
