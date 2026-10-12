

CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_ref_vat_ejr_avg_org_1 AS
SELECT VAT.client_id,
 CRY.currency_iso_cd,
 VAT.st_loc_sid AS store_id,
 VAT.orig_store_nr,
 VAT.dat_formdate,
 L.src_wh_id AS wh_id,
 VAT.cy_month,
  VAT.val_rtl_gross_ejr / CRY.rate_currency_exchange AS val_rtl_gross_ejr,
  VAT.val_rtl_net_ejr / CRY.rate_currency_exchange AS val_rtl_net_ejr,
 VAT.avg_pct_vat_store,
 VAT.avg_pct_vat_store_previous_day,
 VAT.avg_pct_vat_wh,
   TXJ.sales_gross_val_wawi * - 1 / CRY.rate_currency_exchange AS val_retail_wawi_asis,
   TXJ.sales_net_val_wawi * - 1 / CRY.rate_currency_exchange AS val_retail_net_wawi_asis
FROM ldl_p_lew_core_ac.v_wawi_agg_store_avg_vat_values_ejr_1 AS VAT
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS L ON VAT.client_id = L.client_id AND VAT.wh_loc_sid = L.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON VAT.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 LEFT JOIN ldl_p_lew_bil_ac.v_agg_pos_txj_wawi_store_day_1 AS TXJ ON VAT.client_id = TXJ.client_id AND VAT.st_loc_sid =
    TXJ.loc_sid AND VAT.dat_formdate = TXJ.dwh_cal_dt;