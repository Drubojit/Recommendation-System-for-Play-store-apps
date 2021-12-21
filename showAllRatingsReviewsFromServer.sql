SET SERVEROUTPUT ON;

create or replace view myratingview1(AppName, oldRating) as
select S.appname, S.oldRating
from RatingUpdateTrackServer S;


create or replace view myratingview2 as
select T.appname, T.oldRating
from RatingUpdateTrackSite@site1 T;

select * from myratingview1 UNION select * from myratingview2;


create or replace view myreview1(APPNAME, REVIEW,REVIEWRATING) as
select S.appname, S.review,S.reviewrating
from ReviewUpdateTrackServer S;


create or replace view myreview2 as
select T.appname, T.review,T.reviewrating
from ReviewUpdateTrackSite@site1 T;

select * from myreview1 UNION select * from myreview2;









commit;
