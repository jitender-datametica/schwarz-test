CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SUP_SUPPLIER_NEGOT_CNTRY_REF_2
     AS	
        /*#DescStart:#	
        #Subject Areas:# Lieferanten	
        #DescEnd# */	
        SELECT	
          client_id,	
        sup_sid AS supplier_id,	
        main_negot_cntry_cd AS negot_cntry_cd	
    FROM p_lew_bil_ac.v_supplier_2	
    WHERE actual_fg_supplier = 1;