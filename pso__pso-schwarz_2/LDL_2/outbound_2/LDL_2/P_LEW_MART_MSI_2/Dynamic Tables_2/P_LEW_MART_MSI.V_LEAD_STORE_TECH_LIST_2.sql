
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_lead_store_tech_list_2 AS
SELECT OSP.client_id,
 OSP.store_id,
 CRY.curr_tot_id,
 CRY.currency_iso_cd
FROM ldl_p_lew_mart_msi.v_org_store_pre_2 AS OSP
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRT ON OSP.client_id = CRT.client_id AND CURRENT_DATE
   BETWEEN CRT.dat_rec_start AND CRT.dat_rec_end
 INNER JOIN ldl_p_lew_mart_msi.v_ref_currency_2 AS CRY ON CRT.currency_iso_cd = CRY.currency_iso_cd AND CRT.client_id =
   CRY.client_id;