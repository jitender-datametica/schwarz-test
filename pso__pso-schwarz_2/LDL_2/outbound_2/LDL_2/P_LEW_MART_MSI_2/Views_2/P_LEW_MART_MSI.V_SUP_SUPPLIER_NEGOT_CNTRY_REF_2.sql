/* #DescStart:#	
        #Subject Areas:# Lieferanten	
        #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sup_supplier_negot_cntry_ref_2 AS SELECT client_id,
 sup_sid AS supplier_id,
 main_negot_cntry_cd AS negot_cntry_cd
FROM ldl_p_lew_bil_ac.v_supplier_2
WHERE actual_fg_supplier = 1;