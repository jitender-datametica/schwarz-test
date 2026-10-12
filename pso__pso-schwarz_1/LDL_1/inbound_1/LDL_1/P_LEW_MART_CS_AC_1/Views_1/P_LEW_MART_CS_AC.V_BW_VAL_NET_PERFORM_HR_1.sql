/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_BW_VAL_NET_PERFORM_HR_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_BW_VAL_NET_PERFORM_HR_1
(
client_id
,iso_cd
,cy_month
,calender_day
,orig_store_id
,currency_iso_cd
,net_store_productivity_val /* nettoleistungen */
,net_working_hrs            /* nettostunden */
,turnover_val               /* umsatz */
,gross_working_hrs          /* bruttostunden */
,item_qty     /* stueckanzahl */
 )
AS
   SELECT
    client_id,
   iso_cd,
   cy_month,
   calender_day,
   orig_store_id,
   currency_iso_cd,
   net_store_productivity_val,
   net_working_hrs,
   turnover_val,
   gross_working_hrs,
   item_qty
   FROM p_lew_mart_cs.v_bw_val_net_perform_hr_1
;