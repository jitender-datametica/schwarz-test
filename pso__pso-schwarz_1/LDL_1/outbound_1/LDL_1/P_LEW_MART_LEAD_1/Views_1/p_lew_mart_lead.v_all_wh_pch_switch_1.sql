/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_all_wh_pch_switch_1
#----------------------------------------------------------------------------
# History:
#  1.0  17.06.2020    Aleksander Bialek           Initial
#  1.1  2021-04-07    Aleksander Bialek           Re_1-pointing the view to the BIL view (moving whole switch logic to BIL)
#----------------------------------------------------------------------------
*/


/* #DescStart#
#$Revision: 16851 $, $LastChangedBy: abialek $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_all_wh_pch_switch_1 (client_id, wh_id, aspect_id, pch_bnl_switch_fg,
switch_date, dwh_updated) OPTIONS(DESCRIPTION = `STEERING TABLE  FOR ALL WH INCL. VGES`) AS SELECT client_id,
 wh_id,
 aspect_id,
 pch_bnl_switch_fg,
 switch_date,
 dwh_updated
FROM ldl_p_lew_bil_ac.v_org_wh_pch_switch_1 AS V;