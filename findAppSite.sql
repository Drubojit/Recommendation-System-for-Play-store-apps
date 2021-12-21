SET SERVEROUTPUT ON;
SET VERIFY OFF;



ACCEPT X NUMBER PROMPT "ENTER serial Number:"
ACCEPT Y NUMBER PROMPT "ENTER 1 FOR SHOWING ALL APPS OF A CATEGORY,2 FOR BEST  APP,3 FOR APP SUGGESTION:"
DECLARE
 cChoice Number;
 serialNumber CategorySite.id%TYPE;
 NOTEXIST EXCEPTION;
 UNKNOWNOPTION EXCEPTION;
 tempInput varchar(30);
BEGIN
 DBMS_OUTPUT.PUT_LINE('HERE IS THE CATEGORY LIST');
 DBMS_OUTPUT.PUT_LINE('PLEASE SELECT ONE and Select a serial Number:');
 CatagoryInterface.showCategory;
 DBMS_OUTPUT.PUT_LINE((CHR(10)));
 cChoice :=&Y;
 serialNumber :=&X;
 If serialNumber > 10 OR serialNumber<1 THEN
      RAISE NOTEXIST;
ELSIF cChoice>3 or cChoice<1 THEN
      RAISE UNKNOWNOPTION;
	  
 END IF;
    IF serialNumber > 5 THEN
	   
        SELECT categoryName INTO tempInput FROM CategorySite WHERE id=serialNumber;
	ELSE
	   
       SELECT categoryName INTO tempInput FROM   CategoryServer@server1 WHERE id=serialNumber;
	    
    END IF;
	
	
	IF cChoice = 1 THEN
        APPPACKAGE.showAllAPPS(tempInput);
    ELSIF cChoice =2 THEN
        APPPACKAGE.bestAPP(tempInput);
    ELSIF cChoice =3 THEN
        APPPACKAGE.recommendAPPS(tempInput);
	END IF;
 
  




 
 
 EXCEPTION
    WHEN NOTEXIST THEN
	  DBMS_OUTPUT.PUT_LINE('YOUR Serial SELECT ISNOT CORRECT,PLEASE TRY AGAIN');
	WHEN UNKNOWNOPTION THEN
	  DBMS_OUTPUT.PUT_LINE('CHOICE IS NOT VALID and choice must be between 1 and 3');
	  

END;
/
commit;