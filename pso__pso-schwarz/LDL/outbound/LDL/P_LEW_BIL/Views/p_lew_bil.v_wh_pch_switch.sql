/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_wh_pch_switch
#----------------------------------------------------------------------------
# History backup from mart_lead:
#  1.0  30.03.2020    Torsten Bachmann            Initial
#  1.1  29.07.2020    Torsten Bachmann            Table t_wh_pch_switch moved from BIL to CORE layer
#  1.2  16.10.2020    Aleksander Bialek           View repointed from core_switch table to BNL fact table (to be reverted afterdata team fix for core_switch_table)
#  1.3  06.11.2020    Aleksander Bialek           View pointed additionally to materialized switch table "t_wh_pch_switch" (where we will adjust the switch dates manually)
# History:
#  1.0  2021-02-18    Marcin Malec                Copying mart_lead view to bil, using bil switch table "t_wh_pch_switch" (where we will adjust the switch dates manually)
#  1.1  2021-04-08    Aleksander Bialek           Logic moved to script loading BIL table, view re-pointed to the table, dwh_updated column added. 
#  1.2  2021-12-08    Aleksander Bialek           TEMPORARY fix for wh switch date (eventually will be handled via AI) INC3957771, REP3-9836 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_wh_pch_switch (client_id, wh_id, pch_bnl_switch_fg, switch_date, dwh_updated)
OPTIONS(DESCRIPTION = `STEERING TABLE TO DETERMINE WHEN A COUNTRY/WH SWITCHED TO NEW BNL CALCULATION.`) AS SELECT A.client_id
 ,
 A.wh_id,
 A.pch_bnl_switch_fg,
  CASE
  WHEN DATE_DIFF(A.switch_date, cntry_dat.switch_date, DAY) > 30
  THEN cntry_dat.switch_date
  ELSE A.switch_date
  END AS switch_date,
 A.dwh_updated
FROM ldl_p_lew_bil.t_wh_pch_switch AS A
 INNER JOIN (SELECT client_id,
   switch_date,
   dt_cnt
  FROM (SELECT client_id,
     switch_date,
     COUNT(1) AS dt_cnt
    FROM ldl_p_lew_bil.t_wh_pch_switch
    GROUP BY client_id,
     switch_date) AS a
  WHERE (client_id, dt_cnt) IN (SELECT (client_id, MAX(dt_cnt))
     FROM (SELECT client_id,
        switch_date,
        COUNT(1) AS dt_cnt
       FROM ldl_p_lew_bil.t_wh_pch_switch
       GROUP BY client_id,
        switch_date) AS A
     GROUP BY client_id)) AS cntry_dat ON A.client_id = cntry_dat.client_id;