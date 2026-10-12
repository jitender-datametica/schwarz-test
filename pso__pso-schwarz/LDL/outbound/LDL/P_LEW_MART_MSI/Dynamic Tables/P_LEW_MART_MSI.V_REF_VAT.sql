CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_ref_vat AS
SELECT client_id,
 vat_id,
 CAST(pct_vat AS NUMERIC) AS pct_vat,
 vat_desc
FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values AS T1
WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
UNION DISTINCT
SELECT T2.client_id,
 T2.vat_id,
 T2.pct_vat,
 T2.vat_desc
FROM ldl_p_lew_core_ac.v_wawi_ref_vat AS T2
 LEFT JOIN (SELECT client_id
  FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values AS TCK1
  WHERE vat_id > 0
  GROUP BY client_id) AS tck2 ON T2.client_id = tck2.client_id
WHERE CURRENT_DATE BETWEEN T2.dat_rec_start AND T2.dat_rec_end
 AND T2.client_id = T2.language_id
  -- Display data from ref_vat only, if ref_wawi_vat_values has no real data for that client_id

 AND tck2.client_id IS NULL;