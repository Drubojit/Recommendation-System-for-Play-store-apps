SET SERVEROUTPUT ON;
SET VERIFY OFF;


--View Created 
 create or replace view CategoryList1(Serial, CategoryName) as
     select C.id, C.categoryName
     from CategoryServer@server1 C;
	 
	 
--View Created
 create or replace view CategoryList2(Serial, CategoryName) as
     select D.id, D.categoryName
     from CategorySite D;
	 
	 
--Package for controlling category database
CREATE OR REPLACE PACKAGE CatagoryInterface AS
	
	PROCEDURE showCategory;
	
END CatagoryInterface;
/


--category database body
CREATE OR REPLACE PACKAGE BODY CatagoryInterface AS
    
	
	--procedure for showing category
	PROCEDURE showCategory
    IS
    BEGIN
	  DBMS_OUTPUT.PUT_LINE('Serial'||chr(9)||chr(9)||'CategoryName');
      for i in (SELECT * FROM CategoryList1) LOOP
	  
	    DBMS_OUTPUT.PUT_LINE(i.Serial||chr(9)||chr(9)||i.CategoryName); 
	  
	  END LOOP;
	  
	  for j in (SELECT * FROM CategoryList2) LOOP
	  
	    DBMS_OUTPUT.PUT_LINE(j.Serial||chr(9)||chr(9)||j.CategoryName); 
	  
	  END LOOP;
	  
	  
   END showCategory;
   
   
   
 
   
	
END CatagoryInterface;
/





ACCEPT X NUMBER PROMPT "ENTER 1 FOR SHOWING CATEGORYLIST:"


DECLARE
    choice Number;
	
BEGIN
  
   choice :=&X;
   

   IF choice = 1 THEN
       CatagoryInterface.showCategory;
   END IF;



END;
/
commit;
