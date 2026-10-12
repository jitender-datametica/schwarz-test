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
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_STR_DAY_ITEM_INVENTUR_PCH_2
/*
DescStart
$Revision: 16908 $, $LastChangedBy: mmalinowski $
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
     pch.client_id
   , pch.loc_sid_store
   , pch.item_sid
   , pch.pcwo_reason_id
   , pch.sfotype_id
   , pch.currency_iso_cd
   , pch.pch_bnl_switch_fg
   , inv.inv_id
   , inv.dat_formdate
   , inv.dat_valid_from
   , pch.val_price_change
   , pch.dwh_updated
   
   FROM P_LEW_MART_LEAD.v_agg_str_day_item_pch_2 AS pch
   INNER JOIN  P_LEW_CORE_AC.v_wawi_inv_store_2 AS inv
      ON  pch.client_id = inv.client_id
      AND pch.loc_sid_store = inv.st_loc_sid
      AND pch.dwh_cal_dt >= inv.dat_valid_from
      AND pch.dwh_cal_dt <= inv.dat_valid_until
   
      WHERE  inv.inv_fg = 71 AND inv.status_inv_sic = 64 
      ;

