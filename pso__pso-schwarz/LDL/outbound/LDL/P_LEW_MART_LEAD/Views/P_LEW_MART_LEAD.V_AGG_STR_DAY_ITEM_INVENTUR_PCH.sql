/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
#
# History:
#  1.0  19.04.2021    Krawczyk Piotr     REP3-8393 Recreate PV inventur KPI using new PV logic for report INTEGER -A-103
#
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/


/* DescStart
$Revision: 16908 $, $LastChangedBy: mmalinowski $
DescEnd */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_str_day_item_inventur_pch (client_id, loc_sid_store, item_sid,
pcwo_reason_id, sfotype_id, currency_iso_cd, pch_bnl_switch_fg, inv_id, dwh_cal_dt, dat_valid_from, val_price_change,
dwh_updated) AS SELECT PCH.client_id,
 PCH.loc_sid_store,
 PCH.item_sid,
 PCH.pcwo_reason_id,
 PCH.sfotype_id,
 PCH.currency_iso_cd,
 PCH.pch_bnl_switch_fg,
 INV.inv_id,
 INV.dat_formdate AS dwh_cal_dt,
 INV.dat_valid_from,
 PCH.val_price_change,
 PCH.dwh_updated
FROM ldl_p_lew_mart_lead.v_agg_str_day_item_pch AS PCH
 INNER JOIN ldl_p_lew_core_ac.v_wawi_inv_store AS INV ON PCH.client_id = INV.client_id AND PCH.loc_sid_store = INV.st_loc_sid
      AND PCH.dwh_cal_dt >= INV.dat_valid_from AND PCH.dwh_cal_dt <= INV.dat_valid_until
WHERE INV.inv_fg = 71
 AND INV.status_inv_sic = 64;