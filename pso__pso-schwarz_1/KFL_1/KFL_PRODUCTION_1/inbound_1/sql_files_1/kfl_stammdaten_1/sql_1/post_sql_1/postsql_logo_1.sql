CREATE OR REPLACE TABLE dbp_etl.logo_kurz_1
as SELECT * FROM dbp_etl.logo_1;

delete FROM dbp_etl.logo_kurz_1;

insert into dbp_etl.logo_kurz_1 (kzstg, td_insert, td_update)
select kzstg as kzstg, CURRENT_TIMESTAMP,CURRENT_TIMESTAMP
FROM 
(
select substr(kzstg,1,3) as kzstg from dbp_etl.logo_1
union
select substr(kzstg,4,3) as kzstg from dbp_etl.logo_1 where length(kzstg)>3 
union
select substr(kzstg,7,3) as kzstg from dbp_etl.logo_1 where length(kzstg)>6 
union
select substr(kzstg,10,3) as kzstg from dbp_etl.logo_1 where length(kzstg)>9 
union
select substr(kzstg,13,3) as kzstg from dbp_etl.logo_1 where length(kzstg)>12 
union
select substr(kzstg,16,3) as kzstg from dbp_etl.logo_1 where length(kzstg)>15
union
select substr(kzstg,19,3) as kzstg from dbp_etl.logo_1 where length(kzstg)>18
union
select substr(kzstg,22,3) as kzstg from dbp_etl.logo_1 where length(kzstg)>21 
GROUP BY kzstg
)
;

INSERT INTO dbp_data.l_nachhaltigkeitslogo_1 
(LOGO_KZSTG,
 nachhaltigkeitslogo_bez,
 nachhaltigkeitslogo_id
)
SELECT  
        kzstg, 
        'unbekannt', 
        -1
FROM dbp_etl.logo_kurz_1
WHERE kzstg not in (SELECT logo_kzstg FROM dbp_data.l_nachhaltigkeitslogo_1)
  AND kzstg <>''
;
