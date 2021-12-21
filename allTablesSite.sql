clear screen;

drop table CategorySite;

	
create table CategorySite(id number, categoryName varchar2(30),PRIMARY KEY(id));

insert into  CategorySite values(6,'Health and Fitness');
insert into  CategorySite values(7,'Maps and Navigation');
insert into  CategorySite values(8,'Music and Audio');
insert into  CategorySite values(9,'Social');
insert into  CategorySite values(10,'Video Players and Editors');

drop table APPSSITE;
CREATE TABLE APPSSITE(appId NUMBER,appName varchar2(30),appCategory varchar2(30),appSize_MB Number,totalDownloads_M Number,freeOrPremium Number,purchasePrice NUMBER,rating Number,
PRIMARY KEY(appId));

INSERT INTO APPSSITE VALUES(41,'X Launcher Pro','Art and Design',2.8,0.01,1,150,4.6);
INSERT INTO APPSSITE VALUES(42,'ibis Paint','Art and Design',23,0.01,1,750,4.5);
INSERT INTO APPSSITE VALUES(43,'U launcher Pro','Art and Design',7.3,0.005,1,149.99,4.6);
INSERT INTO APPSSITE VALUES(44,'Flipaclip','Art and Design',32,10,0,0,4.4);

INSERT INTO APPSSITE VALUES(45,'Wolfram Alpha','Books and Reference',4.3,1,1,250,4.5);
INSERT INTO APPSSITE VALUES(46,'Knots 3D','Books and Reference',131,0.5,1,500,4.8);
INSERT INTO APPSSITE VALUES(47,'Dictionary.com','Books and Reference',9.8,0.1,1,350,4.4);
INSERT INTO APPSSITE VALUES(48,'X Launcher Pro','Books and Reference',1.7,0.01,1,190,4.2);


INSERT INTO APPSSITE VALUES(49,'Conversations','Communication',9.4,0.01,1,250,4.4);
INSERT INTO APPSSITE VALUES(50,'Teamspeak 3','Communication',32,1,1,90,3.4);
INSERT INTO APPSSITE VALUES(51,'Threema Secure','Communication',28,1,1,250,4.6);
INSERT INTO APPSSITE VALUES(52,'Internet Browser','Communication',50,100,0,0,4.4);


INSERT INTO APPSSITE VALUES(53,'Math Tricks Pro','Education',5.9,0.01,1,148,4.7);
INSERT INTO APPSSITE VALUES(54,'Graphing Calculator+Math Pro','Education',4.1,0.1,1,375,4.8);
INSERT INTO APPSSITE VALUES(55,'Periodic Table','Education',12,0.1,1,150,4.9);
INSERT INTO APPSSITE VALUES(56,'Official DVSA theory KIT','Education',82,0.01,1,450,4.5);


INSERT INTO APPSSITE VALUES(57,'Builder PRO MINECRAFT','Entertainment',14,0.05,1,150,4.5);
INSERT INTO APPSSITE VALUES(58,'Tofee','Entertainment',6.8,5,0,0,4.3);
INSERT INTO APPSSITE VALUES(59,'ZEE5','Entertainment',28,100,0,0,3.3);
INSERT INTO APPSSITE VALUES(60,'Youtube Kids','Entertainment',49,100,0,0,4.3);


INSERT INTO APPSSITE VALUES(61,'Home Workouts Gym','Health and Fitness',31,1,1,150,4.6);
INSERT INTO APPSSITE VALUES(62,'Fittness Trainer','Health and Fitness',53,0.01,1,99,4.7);
INSERT INTO APPSSITE VALUES(63,'White Noise','Health and Fitness',61,0.01,1,80,4.7);
INSERT INTO APPSSITE VALUES(64,'Youtube Kids','Health and Fitness',0.265,0.05,1,150,4.6);


INSERT INTO APPSSITE VALUES(65,'Guru Maps pro','Maps and Navigation',45,0.01,1,1147,4.5);
INSERT INTO APPSSITE VALUES(66,'Speed Camera Radar','Maps and Navigation',11,0.01,1,150,4.3);
INSERT INTO APPSSITE VALUES(67,'Navigation Pro','Maps and Navigation',6.2,0.5,1,300,4.3);
INSERT INTO APPSSITE VALUES(68,'ProMap Cordinates','Maps and Navigation',6,0.005,1,1300,4.6);



INSERT INTO APPSSITE VALUES(69,'USB Audio Player','Music and Audio',35,0.01,1,700,4.1);
INSERT INTO APPSSITE VALUES(70,'Poweramp Full','Music and Audio',0.240,5,1,169,4.6);
INSERT INTO APPSSITE VALUES(71,'Music Player MP3','Music and Audio',20,0.01,1,700,4.5);
INSERT INTO APPSSITE VALUES(72,'Black Player','Music and Audio',12,0.01,1,300,4.3);


INSERT INTO APPSSITE VALUES(73,'Maki Plus','Social',3.3,0.05,1,120,4.0);
INSERT INTO APPSSITE VALUES(74,'Sync For Reddit','Social',8.1,0.01,1,550,4.8);
INSERT INTO APPSSITE VALUES(75,'Fedilab','Social',25,0.005,1,220,4.5);
INSERT INTO APPSSITE VALUES(76,'TweetCasterPro','Social',80,0.008,1,420,4.1);


INSERT INTO APPSSITE VALUES(77,'MX Player Pro','Video Players and Editors',16,1,1,450,4.5);
INSERT INTO APPSSITE VALUES(78,'1DM LITE','Video Players and Editors',13,0.05,1,90,4.6);
INSERT INTO APPSSITE VALUES(79,'Maki Plus','Video Players and Editors',40,0.005,1,150,3.8);
INSERT INTO APPSSITE VALUES(80,'Maki Plus ProMax','Video Players and Editors',3.9,0.01,1,250,3.9);


drop table RatingUpdateTrackSite;
CREATE TABLE RatingUpdateTrackSite(appid NUMBER,appname varchar2(30),oldRating Number);
insert into  RatingUpdateTrackSite VALUES(76,'TweetCasterPro',4.1);


drop table ReviewUpdateTrackSite;
CREATE TABLE ReviewUpdateTrackSite(appid NUMBER,appname varchar2(30),review varchar2(30),reviewrating varchar2(14));
insert into  ReviewUpdateTrackSite VALUES(76,'TweetCasterPro','Excellent','***');
insert into  ReviewUpdateTrackSite VALUES(70,'Poweramp Full','Nice','**');
insert into  ReviewUpdateTrackSite VALUES(67,'Navigation Pro','Good','**');


commit;
