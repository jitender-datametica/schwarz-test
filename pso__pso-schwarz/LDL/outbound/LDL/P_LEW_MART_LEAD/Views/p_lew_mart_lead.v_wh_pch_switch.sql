/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20201106_2646_PV_BNL_LEAD_Switch_Table
#            DDL for v_wh_pch_switch
#----------------------------------------------------------------------------
# History:
#  1.0  30.03.2020    Torsten Bachmann            Initial
#  1.1  29.07.2020    Torsten Bachmann            Table t_wh_pch_switch moved from LDL.P_LEW_TMP.BIL  to CORE layer
#  1.2  16.10.2020    Aleksander Bialek           View repointed from LDL.P_LEW_TMP.core_switch  table to BNL fact table (to be reverted afterdata team fix for core_switch_table)
#  1.3  06.11.2020    Aleksander Bialek    View pointed additionally to materialized switch table "t_wh_pch_switch" (where we will adjust the switch dates manually)
#  1.4  08.04.2021    Aleksander Bialek           Logic moved into LDL.P_LEW_TMP.the  script filling BIl table. View repointed to BIL table.
#----------------------------------------------------------------------------
*/


/* #DescStart#
#$Revision: 16855 $, $LastChangedBy: abialek $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_wh_pch_switch (client_id, wh_id, pch_bnl_switch_fg, switch_date,
dwh_updated) OPTIONS(DESCRIPTION = `STEERING TABLE TO DETERMINE WHEN A COUNTRY/WH SWITCHED TO NEW BNL CALCULATION.`) AS
SELECT *
FROM ldl_p_lew_bil_ac.v_wh_pch_switch;