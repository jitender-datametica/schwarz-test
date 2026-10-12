/* #DescStart#	
      #$Revision: 6244 $, $LastChangedBy: hwieber $	
      #SubjectAreas#: Lieferanten	
      #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sup_cntry_lu AS SELECT negot_cntry_cd
FROM ldl_p_lew_mart_msi.v_sup_supplier_negot_cntry_ref
GROUP BY negot_cntry_cd;