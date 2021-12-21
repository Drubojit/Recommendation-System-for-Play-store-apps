SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE PACKAGE ReviewRatingControlPackage  As 
     FUNCTION findApp(A IN APPSSERVER.appName%TYPE)
     RETURN NUMBER;
	 
	 PROCEDURE updateRating(A IN APPSSERVER.appId%TYPE,B IN APPSSERVER.rating%TYPE);
	 
     PROCEDURE addReviewSection(C IN APPSSERVER.appId%TYPE,D IN ReviewUpdateTrackServer.review%TYPE);
	 
END ReviewRatingControlPackage;
/ 


CREATE OR REPLACE PACKAGE BODY ReviewRatingControlPackage AS
    --finding an app in the database to update rating and giving feedback
    FUNCTION findApp(A IN APPSSERVER.appName%TYPE)
    RETURN NUMBER
	IS
	flag NUMBER:=0;
	tempId APPSSERVER.appId%TYPE;
	BEGIN
	DBMS_OUTPUT.PUT_LINE(A);
	 for i in (SELECT appId FROM APPSSERVER WHERE appName=A) LOOP
	  
	    flag :=1;
		tempId :=i.appId;
        return tempId;		
	  
	  END LOOP;
	  
	   for j in (SELECT appId FROM APPSSITE@site1 WHERE appName=A) LOOP
	  
	       flag :=1;
           tempId :=j.appId;
           return tempId;
	  
	   END LOOP;
	  
	   return flag;
		
      END findApp;
	
	
	
	--update rating function to update an app rating
	PROCEDURE updateRating(A IN APPSSERVER.appId%TYPE,B IN APPSSERVER.rating%TYPE)
	IS
	tempRating NUMBER;
	BEGIN
	    IF B>1 THEN
           DBMS_OUTPUT.PUT_LINE('WRONG OPTION CHOOSEN FOR RATING');
		   
        ELSIF B = 1 THEN
		   IF A <41 THEN
		   
		       FOR i in (SELECT * FROM APPSSERVER WHERE appId=A)LOOP
			    tempRating:=i.rating;
			   END LOOP;
			   tempRating :=tempRating+0.1;
			   UPDATE APPSSERVER SET rating=tempRating WHERE appId=A;
			   DBMS_OUTPUT.PUT_LINE('UPDATE RATINGS DONE');

		   ELSIF A>40 THEN
		        FOR j in (SELECT * FROM APPSSITE@site1 WHERE appId=A)LOOP
			    tempRating:=j.rating;
			    END LOOP;
			    tempRating :=tempRating+0.1;
			    UPDATE APPSSITE@site1 SET rating=tempRating WHERE appId=A;
		        DBMS_OUTPUT.PUT_LINE('UPDATE RATINGS DONE');
		   END IF;
		
		
		ELSIF B=0 THEN
		      IF A<41 THEN
		   
		       FOR i in (SELECT * FROM APPSSERVER WHERE appId=A)LOOP
			    tempRating:=i.rating;
			   END LOOP;
			   tempRating :=tempRating-0.05;
			   UPDATE APPSSERVER SET rating=tempRating WHERE appId=A;
			   DBMS_OUTPUT.PUT_LINE('UPDATE RATINGS DONE');
		      ELSIF A>40 THEN
		        FOR j in (SELECT * FROM APPSSITE@site1 WHERE appId=A)LOOP
			    tempRating:=j.rating;
			    END LOOP;
			    tempRating :=tempRating-0.05;
			    UPDATE APPSSITE@site1 SET rating=tempRating WHERE appId=A;
		        DBMS_OUTPUT.PUT_LINE('UPDATE RATINGS DONE');
		       END IF;
		    

        END IF;		
	  
	  
	  
	END updateRating;
	
	
	
	
	--add review of an app
	PROCEDURE addReviewSection(C IN APPSSERVER.appId%TYPE,D IN ReviewUpdateTrackServer.review%TYPE)
	IS
	tempName ReviewUpdateTrackServer.appName%TYPE;
	BEGIN
	
	      
		  
		  
		  IF C <41 THEN
		    SELECT appName INTO tempName FROM APPSSERVER WHERE appId=C;
		  ELSIF C>40 THEN
		     SELECT appName INTO tempName FROM APPSSITE@site1 WHERE appId=C;
		  END IF;
		  IF D='Excellent' THEN
		    INSERT INTO ReviewUpdateTrackSite@site1 VALUES(C,tempName,D,'***');
	        DBMS_OUTPUT.PUT_LINE('REVIEW UPDATED');
		  ELSIF D='Good' or D='Nice' THEN
		    INSERT INTO ReviewUpdateTrackSite@site1 VALUES(C,tempName,D,'**');
	        DBMS_OUTPUT.PUT_LINE('REVIEW UPDATED');
		  ELSIF D='Bad' or D='Worst' THEN
		    INSERT INTO ReviewUpdateTrackSite@site1 VALUES(C,tempName,D,'*');
	        DBMS_OUTPUT.PUT_LINE('REVIEW UPDATED');
		  ELSE
		    INSERT INTO ReviewUpdateTrackSite@site1 VALUES(C,tempName,D,'*');
	        DBMS_OUTPUT.PUT_LINE('REVIEW UPDATED');
		  END IF;
	
	END addReviewSection;
	
	
	
	
	
END ReviewRatingControlPackage;
/





ACCEPT X NUMBER PROMPT "ENTER 1 FOR RATING OR 2 FOR REVIEW:"
ACCEPT Y CHAR PROMPT "ENTER APP NAME:"
ACCEPT Z NUMBER PROMPT "ENTER 1 FOR POSITIVE RATING AND 0 FOR NEGATIVE RATING:"
ACCEPT W CHAR PROMPT "ENTER YOUR REVIEW:"
DECLARE
  CHOICE NUMBER;
  APPNAME APPSSERVER.appName%TYPE;
  RATINGDATA NUMBER;
  WRONGOPTION EXCEPTION;
  resultFlag NUMBER;
  userReview VARCHAR2(30);
BEGIN
    CHOICE :=&X;
	APPNAME :='&Y';
	RATINGDATA :=&Z;
	userReview :='&W';
	IF CHOICE >2 THEN
	   RAISE WRONGOPTION;
	END IF;
	
	IF CHOICE =1 THEN
	    resultFlag :=ReviewRatingControlPackage.findApp(APPNAME);
		IF resultFlag=0 or resultFlag <0 THEN
		    DBMS_OUTPUT.PUT_LINE('APP NOT FOUND IN DATABASE');
		ELSE
		    ReviewRatingControlPackage.updateRating(resultFlag,RATINGDATA);
	    END IF; 
		
    ELSIF CHOICE=2 THEN
	    resultFlag :=ReviewRatingControlPackage.findApp(APPNAME);
		IF resultFlag=0 or resultFlag <0 THEN
		    DBMS_OUTPUT.PUT_LINE('APP NOT FOUND IN DATABASE');
		ELSE
		    ReviewRatingControlPackage.addReviewSection(resultFlag,userReview);
	    END IF; 
	
	END IF;
	    
	
	
EXCEPTION
    WHEN WRONGOPTION THEN
	   DBMS_OUTPUT.PUT_LINE('YOU CHOOSE THE WRONG OPTION');
	
END;
/
commit;