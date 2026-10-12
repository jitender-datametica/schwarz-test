/*



#----------------------------------------------------------------------------



# @ LIDL Stiftung & Co. KG - DWH / MIS



#----------------------------------------------------------------------------



# Interface: DDL



#----------------------------------------------------------------------------



# History:



#  1.0  01.08.2022    Bialek, Aleksander       Initial Version Part of Liefertreue Dashboard RPA Alternative solution. AD WI: 356666 (Main WI:350713)



#  1.1  20.09.2022    Bachmann, Torsten        Added additional call for Prototype of Liefertreue Dashboard



#  1.2  28.09.2022    Bachmann, Torsten        Added logic to re_2-init tables on QA



#  1.3  17.01.2023    Bachmann, Torsten        P_LOAD_DISPO_POS_HIST has to be called with a parameter



#  1.4  21.04.2023    Bialek, Aleksander       Added additional call for Prototype of EK Preis calculation, needed for Kalkulation basis ABV KPI (ADO WI:461587)



#  1.5  28.06.2023    Bialek, Aleksander       ADO WI:494493 Removing additional calls for LFT and Kalkulation basis ABV KPI after adding them to LEAD.plan (ADO WI:493837)



#----------------------------------------------------------------------------



*/



CREATE OR REPLACE PROCEDURE p_lew_mart_lead.p_lft_dash_data_start_processing()
BEGIN
DECLARE stmnt0 STRING;
DECLARE rs0 ARRAY<JSON>;
DECLARE stmnt STRING;
DECLARE iterator_rs0 INT64 DEFAULT -1;
BEGIN TRANSACTION;

SET stmnt0 = '''WITH DTS AS (SELECT DATE(MAX(dwh_updated)) AS eks_dt,
   EXTRACT(HOUR FROM CURRENT_TIMESTAMP()) AS curr_hr,
   CURRENT_DATE("Europe/Berlin") AS curr_dt
  FROM p_lew_precore.t_cache_eks_file_2) (SELECT CASE
    WHEN curr_hr > 8 AND eks_dt = curr_dt OR curr_hr < 8
    THEN 'Call p_lew_mart_lead.p_lft_dash_data_processing();'
    ELSE 'CREATE OR REPLACE TEMPORARY TABLE dummy_tmp AS SELECT 0 AS C;'
    END AS txt,
   curr_hr,
    CASE
    WHEN curr_dt < DATE '2022-10-23'
    THEN 1
    ELSE 0
    END AS init_fg
  FROM DTS)'''; 

EXECUTE IMMEDIATE format("""
SELECT ARRAY_AGG(JSON_ARRAY(%s))
FROM (%s)
""",  'txt,curr_hr,init_fg',  stmnt0)
INTO rs0 ;
SET iterator_rs0  =  iterator_rs0  + 1;
SET stmnt  =  JSON_EXTRACT_SCALAR(rs0[SAFE_OFFSET(iterator_rs0)], '$[0]');

EXECUTE IMMEDIATE (stmnt);

COMMIT TRANSACTION;
END;

