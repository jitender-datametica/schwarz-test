/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for v_wh_pch_switch_2
#----------------------------------------------------------------------------
# History:
#  1.0  30.03.2020    Torsten Bachmann            Initial
#  1.1  16.10.2020    Aleksander Bialek           View adjusted to lew_mart_lead.v_wh_pch_switch_2 according to changes 
#  1.2  07.04.2021    Aleksander Bialek           Adding dwh_updated 
#----------------------------------------------------------------------------
*/


/* #DescStart#
#$Revision: 16850 $, $LastChangedBy: abialek $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_wh_pch_switch_2 (client_id, wh_id, pch_bnl_switch_fg, switch_date,
dwh_updated) OPTIONS(DESCRIPTION = `STEERING TABLE TO DETERMINE WHEN A COUNTRY_2/WH SWITCHED TO NEW BNL CALCULATION.`) AS
SELECT *
FROM ldl_p_lew_mart_lead.v_wh_pch_switch_2 AS V;