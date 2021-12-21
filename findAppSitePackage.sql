SET SERVEROUTPUT ON;
SET VERIFY OFF;

--Creating package for different procedure of app finding	 
	 
CREATE OR REPLACE PACKAGE APPPACKAGE AS
	
	PROCEDURE showAllAPPS(A IN APPSSITE.appCategory%TYPE);
	PROCEDURE bestAPP(A IN APPSSITE.appCategory%TYPE);
	PROCEDURE recommendAPPS(A IN APPSSITE.appCategory%TYPE);

END APPPACKAGE;
/


CREATE OR REPLACE PACKAGE BODY APPPACKAGE AS
    
	
	--procedure for showing ALLAPPS of a category
	PROCEDURE showAllAPPS(A IN APPSSITE.appCategory%TYPE)
    IS
    BEGIN
	  DBMS_OUTPUT.PUT_LINE('APPNAME'||chr(9)||chr(9)||'SIZE_MB'||CHR(9)||'DOWNLOADS_MILLION'||CHR(9)||'RATINGS');
	  DBMS_OUTPUT.PUT_LINE(chr(10));
      for i in (SELECT * FROM APPSSERVER@server1 WHERE appCategory=A ORDER BY APPSSERVER.rating DESC ) LOOP
	  
	    DBMS_OUTPUT.PUT_LINE(i.appName||chr(9)||chr(9)||i.appSize_MB||CHR(9)||i.totalDownloads_M||chr(9)||i.rating); 
	  
	  END LOOP;
	  
	   for j in (SELECT * FROM APPSSITE WHERE appCategory=A ORDER BY rating DESC) LOOP
	  
	    DBMS_OUTPUT.PUT_LINE(j.appName||chr(9)||chr(9)||j.appSize_MB||CHR(9)||j.totalDownloads_M||chr(9)||j.rating); 
	  
	  END LOOP;
	  
   END showAllAPPS;
   
   
   
   
   --procedure for showing bestAPP of a category from server and site
   PROCEDURE bestAPP(A IN APPSSITE.appCategory%TYPE)
   IS
    firstLoopRating APPSSITE.rating%TYPE;
	firstLoopId     APPSSITE.appId%TYPE;
	secondLoopRating APPSSITE.rating%TYPE;
	secondLoopId     APPSSITE.appId%TYPE;
   BEGIN
      DBMS_OUTPUT.PUT_LINE('APPNAME'||chr(9)||chr(9)||'SIZE_MB'||CHR(9)||'DOWNLOADS_MILLION'||CHR(9)||'RATINGS');
	  DBMS_OUTPUT.PUT_LINE(chr(10));
      for i in (SELECT * FROM APPSSERVER@server1 WHERE appCategory=A ORDER BY rating DESC ) LOOP
	  
	    firstLoopId :=i.appid;
		firstLoopRating :=i.rating;
		EXIT;
	  
	  END LOOP;
	  
	   for j in (SELECT * FROM APPSSITE WHERE appCategory=A ORDER BY rating DESC) LOOP
	       secondLoopId :=j.appid;
		   secondLoopRating :=j.rating;
		   EXIT;
	    
	   END LOOP;
	   
	   IF firstLoopRating > secondLoopRating THEN 
	        for k in (SELECT * FROM APPSSERVER@server1 WHERE appid=firstLoopId) LOOP
	  
	            DBMS_OUTPUT.PUT_LINE(k.appName||chr(9)||chr(9)||k.appSize_MB||CHR(9)||k.totalDownloads_M||chr(9)||k.rating); 
	  
	        END LOOP;
	   ELSIF secondLoopRating >firstLoopRating THEN 
	        
	       for m in (SELECT * FROM APPSSITE WHERE appid=secondLoopId) LOOP
	  
	            DBMS_OUTPUT.PUT_LINE(m.appName||chr(9)||chr(9)||m.appSize_MB||CHR(9)||m.totalDownloads_M||chr(9)||m.rating); 
	  
	        END LOOP;
			
			
	   ELSIF secondLoopRating = firstLoopRating THEN
	    for k in (SELECT * FROM APPSSERVER@server1 WHERE appid=firstLoopId) LOOP
	  
	            DBMS_OUTPUT.PUT_LINE(k.appName||chr(9)||chr(9)||k.appSize_MB||CHR(9)||k.totalDownloads_M||chr(9)||k.rating); 
	  
	        END LOOP;
		for m in (SELECT * FROM APPSSITE WHERE appid=secondLoopId) LOOP
	  
	            DBMS_OUTPUT.PUT_LINE(m.appName||chr(9)||chr(9)||m.appSize_MB||CHR(9)||m.totalDownloads_M||chr(9)||m.rating); 
	  
	        END LOOP;
	       
	   
	   END IF ;
   
   END bestAPP;
   
   
   
   
   
   --procedure for showing recommendAPPS of a category
   PROCEDURE recommendAPPS(A IN APPSSITE.appCategory%TYPE)
   IS
   
   status Number :=0;
   status1 Number:=0;
   
   BEGIN
    DBMS_OUTPUT.PUT_LINE('APPNAME'||chr(9)||chr(9)||'SIZE_MB'||CHR(9)||'DOWNLOADS_MILLION'||CHR(9)||'RATINGS');
    for i in (SELECT * FROM APPSSERVER@server1 WHERE appCategory=A ORDER BY rating DESC ) LOOP
	    status :=status+1;
	    DBMS_OUTPUT.PUT_LINE(i.appName||chr(9)||chr(9)||i.appSize_MB||CHR(9)||i.totalDownloads_M||chr(9)||i.rating);
	    IF status = 2 THEN
		   EXIT;
		END IF;
	END LOOP;
	
	
	 for j in (SELECT * FROM APPSSITE WHERE appCategory=A ORDER BY rating DESC) LOOP
	    status1 :=status1+1;
	    DBMS_OUTPUT.PUT_LINE(j.appName||chr(9)||chr(9)||j.appSize_MB||CHR(9)||j.totalDownloads_M||chr(9)||j.rating); 
	    IF status1=2 THEN
		    EXIT;
		END IF;
	  END LOOP;
   
   
   END recommendAPPS;
   
  
	
END APPPACKAGE;
/


commit;