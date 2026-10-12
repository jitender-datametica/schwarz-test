/* #DescStart#	
       #$Revision: 7426 $, $LastChangedBy: cmarose $	
       #SubjectAreas#: Lieferanten	
       #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sup_supplier_skey_1 AS SELECT client_id,
 sup_sid AS supplier_id,
  CASE
  WHEN SUBSTR(src_lifnr, 1, 1) > '9'
  THEN COALESCE(LTRIM(src_orig_supplier_nr), src_lifnr)
  ELSE COALESCE(LTRIM(src_orig_supplier_nr), CAST(ROUND(CAST(src_lifnr AS BIGNUMERIC), 0) AS STRING))
  END AS orig_supplier_nr,
 dwh_valid_from AS dat_rec_start,
 dwh_valid_to AS dat_rec_end
FROM ldl_p_lew_bil_ac.v_supplier_1
WHERE actual_fg_supplier = 1;