CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SUP_CNTRY_LU_2
   AS	
      /*	
      #DescStart#	
      #$Revision: 6244 $, $LastChangedBy: hwieber $	
      #SubjectAreas#: Lieferanten	
      #DescEnd#	
      */	
	
      SELECT	
        negot_cntry_cd	
        FROM p_lew_mart_msi.v_sup_supplier_negot_cntry_ref_2	
      GROUP BY 1;