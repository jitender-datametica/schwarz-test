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

CREATE OR REPLACE PROCEDURE P_LEW_MART_LEAD.P_LFT_DASH_DATA_START_PROCESSING()
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS '
var stmnt0 = `WITH dts as (
select Cast(max(dwh_updated) as date) eks_dt
, extract(hour from current_timestamp) curr_hr 
, CURRENT_DATE as curr_dt
from P_LEW_PRECORE.T_CACHE_EKS_FILE_2
) 
Select Case when curr_hr>8 and eks_dt=curr_dt then ''Call P_LEW_MART_LEAD.P_LFT_DASH_DATA_PROCESSING();''
            when curr_hr <8 then ''Call P_LEW_MART_LEAD.P_LFT_DASH_DATA_PROCESSING();''
            else ''CREATE OR REPLACE TEMPORARY TABLE P_LEW_TMP.DUMMY_tmp AS SELECT 0 AS C;''
            END txt
, curr_hr
, CASE WHEN curr_dt < DATE ''2022-10-23'' THEN 1 ELSE 0 END init_fg
from dts;`
var rs0 = snowflake.createStatement({sqlText : stmnt0}).execute();
rs0.next();
var stmnt = rs0.getColumnValue(1);
snowflake.createStatement({sqlText : stmnt}).execute();
snowflake.createStatement({sqlText : `COMMIT;`}).execute();
';