SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE PACKAGE FindSubscription  As 
     FUNCTION findPrice(A IN APPSSERVER.appName%TYPE,B IN NUMBER,C IN APPSSERVER.appCategory%TYPE)
     RETURN NUMBER;

END FindSubscription;
/ 



CREATE OR REPLACE PACKAGE BODY FindSubscription AS

    FUNCTION findPrice(A IN APPSSERVER.appName%TYPE,B IN NUMBER,C IN APPSSERVER.appCategory%TYPE)
    RETURN NUMBER
	IS
	total NUMBER:=0;
	BEGIN
	   FOR i in (SELECT * FROM APPSSERVER where appName=A and appCategory=C)LOOP
	      
		    total :=i.purchasePrice*B;
	        RETURN total;
		 
	   END LOOP;
	   
	   
	    FOR j in (SELECT * FROM APPSSITE@site1 where appName=A and appCategory=C)LOOP
	      total :=j.purchasePrice*B;
	      RETURN total;
	    END LOOP;

	 RETURN total;
		
END findPrice;
	
	
	
	
END FindSubscription;
/



ACCEPT X CHAR PROMPT "ENTER CategoryName:"
ACCEPT Y CHAR PROMPT "ENTER APPName:"
ACCEPT Z NUMBER PROMPT "ENTER month of subscription you need::"
DECLARE
cName APPSSERVER.appCategory%TYPE;
inputAppName APPSSERVER.appName%TYPE;
month1 NUMBER;
totalPrice Number:=0;
ERROR EXCEPTION;
BEGIN
   CatagoryInterface.showCategory;
   DBMS_OUTPUT.PUT_LINE((chr(10)));
   cName :='&X';
   inputAppName :='&Y';
   month1 :=&Z;
   APPPACKAGE.findPremiumApp(cName);
   
   
   IF month1<0 THEN
       month1:=month1*(-1);
   
   ELSIF month1=0 THEN
       month1:=1;
   
   END IF;
   
   totalPrice:=FindSubscription.findPrice(inputAppName,month1,cName);
   IF totalPrice=0 THEN
       RAISE ERROR;
   ELSE
       DBMS_OUTPUT.PUT_LINE('Total Subscription Fee:'||' '||totalPrice);
   END IF;
EXCEPTION
      WHEN ERROR THEN
            DBMS_OUTPUT.PUT_LINE('NOT FOUND');	  
END;
/
commit;