SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE PACKAGE ReviewRatingControlPackage  As 
     FUNCTION findApp(A IN APPSSITE.appName%TYPE)
     RETURN NUMBER;
	 PROCEDURE addReviewSection(C IN APPSSITE.appId%TYPE,D IN ReviewUpdateTrackSite.review%TYPE);
	 
END ReviewRatingControlPackage;
/ 




CREATE OR REPLACE PACKAGE BODY ReviewRatingControlPackage AS
    --finding an app in the database to update rating and giving feedback
    FUNCTION findApp(A IN APPSSITE.appName%TYPE)
    RETURN NUMBER
	IS
	flag NUMBER:=0;
	tempId APPSSITE.appId%TYPE;
	BEGIN
	DBMS_OUTPUT.PUT_LINE(A);
	 for i in (SELECT appId FROM APPSSERVER@server1 WHERE appName=A) LOOP
	  
	    flag :=1;
		tempId :=i.appId;
        return tempId;		
	  
	  END LOOP;
	  
	   for j in (SELECT appId FROM APPSSITE WHERE appName=A) LOOP
	  
	       flag :=1;
           tempId :=j.appId;
           return tempId;
	  
	   END LOOP;
	  
	   return flag;
		
      END findApp;
	
	
	
	
	
	
	
	--add review of an app
	PROCEDURE addReviewSection(C IN APPSSITE.appId%TYPE,D IN ReviewUpdateTrackSite.review%TYPE)
	IS
	tempName ReviewUpdateTrackSite.appName%TYPE;
	BEGIN
	
	      
		  IF C <41 THEN
		    SELECT appName INTO tempName FROM APPSSERVER@server1 WHERE appId=C;
		  ELSIF C>40 THEN
		     SELECT appName INTO tempName FROM APPSSITE WHERE appId=C;
		  END IF;
		  IF D='Excellent' THEN
		    INSERT INTO ReviewUpdateTrackServer@server1 VALUES(C,tempName,D,'***');
	        DBMS_OUTPUT.PUT_LINE('REVIEW UPDATED');
		  ELSIF D='Good' or D='Nice' THEN
		    INSERT INTO ReviewUpdateTrackServer@server1 VALUES(C,tempName,D,'**');
	        DBMS_OUTPUT.PUT_LINE('REVIEW UPDATED');
		  ELSIF D='Bad' or D='Worst' THEN
		    INSERT INTO ReviewUpdateTrackServer@server1 VALUES(C,tempName,D,'*');
	        DBMS_OUTPUT.PUT_LINE('REVIEW UPDATED');
		  ELSE
		    INSERT INTO ReviewUpdateTrackServer@server1 VALUES(C,tempName,D,'*');
	        DBMS_OUTPUT.PUT_LINE('REVIEW UPDATED');
		  END IF;
	
	END addReviewSection;
	
	
	
	
	
END ReviewRatingControlPackage;
/








ACCEPT X NUMBER PROMPT "ENTER 1 FOR Review :"
ACCEPT Y CHAR PROMPT "ENTER APP NAME:"
ACCEPT W CHAR PROMPT "ENTER YOUR REVIEW:"
DECLARE
  CHOICE NUMBER;
  APPNAME APPSSITE.appName%TYPE;
  WRONGOPTION EXCEPTION;
  resultFlag NUMBER;
  userReview VARCHAR2(30);
BEGIN
    CHOICE :=&X;
	APPNAME :='&Y';
	userReview :='&W';
	IF CHOICE >1 THEN
	   RAISE WRONGOPTION;
	END IF;
	
	IF CHOICE=1 THEN
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