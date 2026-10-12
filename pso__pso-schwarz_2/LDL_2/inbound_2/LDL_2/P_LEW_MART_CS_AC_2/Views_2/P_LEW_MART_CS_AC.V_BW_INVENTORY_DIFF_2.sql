/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_BW_INVENTORY_DIFF_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_BW_INVENTORY_DIFF_2
(
 client_id
,iso_cd
,cy_month
,kpi_aspect
,wh_id
,wh_descr
,v_id
,v_descr
,currency_iso_cd
,inventory_diff_sic_val
,inventory_turnover_sic_val
,inventory_diff_percent
 )
AS
   SELECT
     client_id,
   iso_cd,
   cy_month,
   kpi_aspect,
   wh_id,
   wh_descr,
   v_id,
   v_descr,
   currency_iso_cd,
   inventory_diff_sic_val,
   inventory_turnover_sic_val,
   inventory_diff_percent
   FROM p_lew_mart_cs.v_bw_inventory_diff_2
;