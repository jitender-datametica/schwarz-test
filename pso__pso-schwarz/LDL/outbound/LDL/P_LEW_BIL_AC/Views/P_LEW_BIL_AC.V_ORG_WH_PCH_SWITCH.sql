/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_wh_pch_switch
#----------------------------------------------------------------------------
# History:
#  1.1 2021-04-07 Aleksander Bialek       Moving the BNL switch solution from LDL.P_LEW_TMP.mart  lead to BIL 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_org_wh_pch_switch (aspect_id, client_id, wh_id, pch_bnl_switch_fg, switch_date
, dwh_updated) OPTIONS(DESCRIPTION = `STEERING TABLE TO DETERMINE WHEN A COUNTRY/WH SWITCHED TO NEW BNL CALCULATION.`)
AS SELECT *
FROM ldl_p_lew_bil.v_org_wh_pch_switch AS V;