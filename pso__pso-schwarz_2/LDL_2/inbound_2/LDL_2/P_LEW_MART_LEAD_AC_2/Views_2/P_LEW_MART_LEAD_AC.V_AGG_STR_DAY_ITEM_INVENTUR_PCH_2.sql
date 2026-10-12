/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
#
# History:
#  1.0  19.04.2021    Krawczyk Piotr     REP3-8393 Recreate PV inventur_2 KPI using new PV logic for report INT-A-103
#
#----------------------------------------------------------------------------
*/


/*
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STR_DAY_ITEM_INVENTUR_PCH_2
/*
DescStart
$Revision: 16909 $, $LastChangedBy: mmalinowski $
DescEnd
*/
(
     client_id
   , loc_sid_store
   , item_sid
   , pcwo_reason_id
   , sfotype_id
   , currency_iso_cd
   , pch_bnl_switch_fg
   , inv_id
   , dwh_cal_dt
   , dat_valid_from
   , val_price_change
   , dwh_updated
   )
   AS 
   SELECT
     client_id
   , loc_sid_store
   , item_sid
   , pcwo_reason_id
   , sfotype_id
   , currency_iso_cd
   , pch_bnl_switch_fg
   , inv_id
   , dwh_cal_dt
   , dat_valid_from
   , val_price_change
   , dwh_updated
   
   FROM P_LEW_MART_LEAD.v_agg_str_day_item_inventur_pch_2
      ;
