/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_wh_pch_switch_1
#----------------------------------------------------------------------------
# History:
#  1.0 2021-02-18 Marcin Malec       Copying mart_lead view to bil
#  1.1 2021-04-07 Aleksander Bialek       Adding dwh_updated column 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_wh_pch_switch_1 (client_id, wh_id, pch_bnl_switch_fg, switch_date, dwh_updated)
OPTIONS(DESCRIPTION = `STEERING TABLE TO DETERMINE WHEN A COUNTRY_1/WH SWITCHED TO NEW BNL CALCULATION.`) AS SELECT *
FROM ldl_p_lew_bil.v_wh_pch_switch_1 AS V;