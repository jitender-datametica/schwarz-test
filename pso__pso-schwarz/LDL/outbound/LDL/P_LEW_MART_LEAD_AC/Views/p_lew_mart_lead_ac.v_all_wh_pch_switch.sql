/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_wh_pch_switch
#----------------------------------------------------------------------------
# History:
#  1.0  17.06.2020    Aleksander Bialek           Initial
#  1.1  07.04.2021    Aleksander Bialek           Removing dwh_created column (obsolete)
#----------------------------------------------------------------------------
*/


/* #DescStart#
#$Revision: 16850 $, $LastChangedBy: abialek $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_all_wh_pch_switch (client_id, wh_id, aspect_id, pch_bnl_switch_fg,
switch_date, dwh_updated) OPTIONS(DESCRIPTION = `STEERING TABLE FOR ALL WH INCL. VGES`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_all_wh_pch_switch AS V;