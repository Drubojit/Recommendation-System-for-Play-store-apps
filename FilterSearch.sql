SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE PACKAGE filterSearchPackage  As 
    PROCEDURE globalSearch;
	PROCEDURE downloadsBasedSearch(A IN APPSSERVER.appCategory%TYPE);
	 
END filterSearchPackage;
/ 


CREATE OR REPLACE PACKAGE BODY filterSearchPackage AS
     --best rated apps with free apps and paid apps overall category
     PROCEDURE globalSearch
	 IS
	 COUNT1 NUMBER:=0;
	 paidAPPCount Number:=0;
	 freeAPPCount Number:=0;
	 BEGIN
	    DBMS_OUTPUT.PUT_LINE('APPNAME'||CHR(9)||CHR(9)||'APPCATEGORY'||CHR(9)||CHR(9)||'RATING');
		DBMS_OUTPUT.PUT_LINE((chr(10)));
	    FOR i  in (SELECT * FROM APPSSERVER where rating in(SELECT MAX(rating) FROM APPSSERVER GROUP BY appCategory))LOOP
		
		  DBMS_OUTPUT.PUT_LINE(i.appName||chr(9)||chr(9)||i.appCategory||chr(9)||chr(9)||i.rating);
		  DBMS_OUTPUT.PUT_LINE((chr(10)));
		  COUNT1 :=COUNT1+1;
		  IF i.freeOrPremium=1 THEN
		    
		    paidAPPCount :=paidAPPCount+1;
		  END IF;
		  
		END LOOP;
        FOR j  in (SELECT * FROM APPSSITE@site1 where rating in(SELECT MAX(rating) FROM APPSSITE@site1 GROUP BY appCategory))LOOP
		
		  DBMS_OUTPUT.PUT_LINE(j.appName||chr(9)||chr(9)||j.appCategory||chr(9)||chr(9)||j.rating);
		  DBMS_OUTPUT.PUT_LINE((chr(10)));
		  COUNT1 :=COUNT1+1;
		  IF j.freeOrPremium=1 THEN
		    
		    paidAPPCount :=paidAPPCount+1;
		  END IF;
		  
		END LOOP;
		
		DBMS_OUTPUT.PUT_LINE('TOTAL BEST RATED APPS ALL OVER 10 CATEGORY:'||''||COUNT1);
		freeAPPCount :=COUNT1-paidAPPCount;
		DBMS_OUTPUT.PUT_LINE('TOTAL BEST RATED PAID APPS ALL OVER 10 CATEGORY:'||''||paidAPPCount);
		DBMS_OUTPUT.PUT_LINE('TOTAL BEST RATED FREE APPS ALL OVER 10 CATEGORY:'||''||freeAPPCount);
	 END globalSearch;
	
	
	
	--Based on best Total downloads app search of a category
	PROCEDURE downloadsBasedSearch(A IN APPSSERVER.appCategory%TYPE)
	IS
	firstLoopDownload APPSSERVER.totalDownloads_M%TYPE;
	firstLoopId       APPSSERVER.appId%TYPE;
	secondLoopDownload APPSSERVER.totalDownloads_M%TYPE;
	secondLoopId      APPSSERVER.appId%TYPE;
   BEGIN
      DBMS_OUTPUT.PUT_LINE('APPNAME'||chr(9)||chr(9)||'SIZE_MB'||CHR(9)||'DOWNLOADS_MILLION');
	  DBMS_OUTPUT.PUT_LINE(chr(10));
      for i in (SELECT * FROM APPSSERVER WHERE appCategory=A ORDER BY totalDownloads_M DESC ) LOOP
	  
	    firstLoopId :=i.appid;
		firstLoopDownload :=i.totalDownloads_M;
		EXIT;
	  
	  END LOOP;
	  
	   for j in (SELECT * FROM APPSSITE@site1 WHERE appCategory=A ORDER BY totalDownloads_M DESC) LOOP
	       secondLoopId :=j.appid;
		   secondLoopDownload :=j.totalDownloads_M;
		   EXIT;
	    
	   END LOOP;
	   
	   IF firstLoopDownload > secondLoopDownload THEN 
	        for k in (SELECT * FROM APPSSERVER WHERE appid=firstLoopId) LOOP
	  
	            DBMS_OUTPUT.PUT_LINE(k.appName||chr(9)||chr(9)||k.appSize_MB||CHR(9)||k.totalDownloads_M); 
	  
	        END LOOP;
	   ELSIF secondLoopDownload >firstLoopDownload THEN 
	        
	       for m in (SELECT * FROM APPSSITE@site1 WHERE appid=secondLoopId) LOOP
	  
	            DBMS_OUTPUT.PUT_LINE(m.appName||chr(9)||chr(9)||m.appSize_MB||CHR(9)||m.totalDownloads_M); 
	  
	        END LOOP;
			
			
	   ELSIF secondLoopDownload = firstLoopDownload THEN
	    for k in (SELECT * FROM APPSSERVER WHERE appid=firstLoopId) LOOP
	  
	            DBMS_OUTPUT.PUT_LINE(k.appName||chr(9)||chr(9)||k.appSize_MB||CHR(9)||k.totalDownloads_M); 
	  
	        END LOOP;
		for m in (SELECT * FROM APPSSITE@site1 WHERE appid=secondLoopId) LOOP
	  
	            DBMS_OUTPUT.PUT_LINE(m.appName||chr(9)||chr(9)||m.appSize_MB||CHR(9)||m.totalDownloads_M); 
	  
	        END LOOP;
	       
	   
	   END IF ;
	
	
	
	
	
	END downloadsBasedSearch;
	
	
	
	
END filterSearchPackage;
/




ACCEPT X NUMBER PROMPT "1 FOR GLOBAL,2 FOR DOWNLOADS:"
ACCEPT Y CHAR PROMPT "ENTER CategoryName:"
DECLARE
choice Number;
catName APPSSERVER.appCategory%TYPE;
UNKNOWNOPTION EXCEPTION;
BEGIN
 choice:=&X;
 catName:='&Y';
 CatagoryInterface.showCategory;
 DBMS_OUTPUT.PUT_LINE((CHR(9)));
 IF choice<=0 or choice>2 THEN
    RAISE UNKNOWNOPTION;
 END IF;
 
 
IF choice=1 THEN
    filterSearchPackage.globalSearch;
ELSIF  choice=2 THEN
     filterSearchPackage.downloadsBasedSearch(catName);
END IF;


EXCEPTION
     WHEN UNKNOWNOPTION THEN
	  DBMS_OUTPUT.PUT_LINE('CHOICE IS NOT VALID and choice must be between 1 and 2');

END;
/
commit;