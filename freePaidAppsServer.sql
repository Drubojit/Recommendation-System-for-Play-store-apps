SET SERVEROUTPUT ON;
SET VERIFY OFF;
ACCEPT X CHAR PROMPT "ENTER APPNAME:"
ACCEPT Z NUMBER PROMPT "ENTER SERIAL NUMBER:"
ACCEPT Y NUMBER PROMPT "1 FOR SEARCH,2 FOR SEARCH WITHOUT CATEGORY,3 FOR FREE APPS,4 FOR PAID APPS :"
DECLARE
  inputAppName APPSSERVER.appName%TYPE;
  choice Number;
  serialNumber CategoryServer.id%TYPE :=&z;
  NOTEXIST EXCEPTION;
  UNKNOWNOPTION EXCEPTION;
  tempInput varchar(30);
BEGIN
   DBMS_OUTPUT.PUT_LINE('HERE IS THE CATEGORY LIST');
   DBMS_OUTPUT.PUT_LINE('PLEASE SELECT ONE and Select a serial Number:');
   CatagoryInterface.showCategory;
   DBMS_OUTPUT.PUT_LINE((CHR(10)));
   inputAppName :='&X';
   choice :=&Y;

   
   
   
    If serialNumber > 10 OR serialNumber<1 THEN
      RAISE NOTEXIST;
    ELSIF choice>4 or choice<1 THEN
      RAISE UNKNOWNOPTION;
	END IF;
	
    IF serialNumber > 5 THEN
	   
        SELECT categoryName INTO tempInput FROM CategorySite@site1 WHERE id=serialNumber;
	ELSE
	   
       SELECT categoryName INTO tempInput FROM   CategoryServer WHERE id=serialNumber;
	    
    END IF;
	
	
	IF choice = 1 THEN
        APPPACKAGE.searchApp(tempInput,inputAppName);
	ELSIF choice = 2 THEN
	    APPPACKAGE.searchAppWithoutCategory(inputAppName);
	ELSIF choice=3 THEN
	     APPPACKAGE.findFreeApp(tempInput);
	ELSIF choice=4 THEN
	     APPPACKAGE.findPremiumApp(tempInput);
    
	END IF;
 
  




 
 
 EXCEPTION
    WHEN NOTEXIST THEN
	  DBMS_OUTPUT.PUT_LINE('YOUR SERIAL SELECT ISNOT CORRECT,PLEASE TRY AGAIN');
	WHEN UNKNOWNOPTION THEN
	  DBMS_OUTPUT.PUT_LINE('CHOICE IS NOT VALID and choice must be between 1 and 4');
   
   
   
END;
/
commit;