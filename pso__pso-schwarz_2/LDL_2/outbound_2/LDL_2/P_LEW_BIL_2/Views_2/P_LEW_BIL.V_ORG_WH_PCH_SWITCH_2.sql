/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_wh_pch_switch_2
#----------------------------------------------------------------------------
# History:
#  1.1 2021-04-07 Aleksander Bialek       Moving the BNL switch solution from LDL.P_LEW_TMP.mart  lead to BIL 
#  1.2 2021-12-08 Aleksander Bialek       TEMPORARY fix for wh switch date (eventually will be handled via AI) INC3957771, REP3-9836 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_org_wh_pch_switch_2 (aspect_id, client_id, wh_id, pch_bnl_switch_fg, switch_date,
dwh_updated) OPTIONS(DESCRIPTION = `STEERING TABLE TO DETERMINE WHEN A COUNTRY_2/WH SWITCHED TO NEW BNL CALCULATION.`) AS
SELECT A.aspect_id,
 A.client_id,
 A.wh_id,
 A.pch_bnl_switch_fg,
  CASE
  WHEN DATE_DIFF(A.switch_date, cntry_dat.switch_date, DAY) > 30
  THEN cntry_dat.switch_date
  ELSE A.switch_date
  END AS switch_date,
 A.dwh_updated
FROM ldl_p_lew_bil.t_org_wh_pch_switch_2 AS A
 INNER JOIN (SELECT client_id,
   switch_date,
   dt_cnt
  FROM (SELECT client_id,
     switch_date,
     COUNT(1) AS dt_cnt
    FROM ldl_p_lew_bil.t_wh_pch_switch_2
    GROUP BY client_id,
     switch_date) AS a
  WHERE (client_id, dt_cnt) IN (SELECT (client_id, MAX(dt_cnt))
     FROM (SELECT client_id,
        switch_date,
        COUNT(1) AS dt_cnt
       FROM ldl_p_lew_bil.t_wh_pch_switch_2
       GROUP BY client_id,
        switch_date) AS A
     GROUP BY client_id)) AS cntry_dat ON A.client_id = cntry_dat.client_id;