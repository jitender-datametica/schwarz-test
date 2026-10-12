/* #DescStart#	
      #$Revision: 6244 $, $LastChangedBy: hwieber $	
      #SubjectAreas#: Lieferanten	
      #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sup_cntry_lu_2 AS SELECT negot_cntry_cd
FROM ldl_p_lew_mart_msi.v_sup_supplier_negot_cntry_ref_2
GROUP BY negot_cntry_cd;