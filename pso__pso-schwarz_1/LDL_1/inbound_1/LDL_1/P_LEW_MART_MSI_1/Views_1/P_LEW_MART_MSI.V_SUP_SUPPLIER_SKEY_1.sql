CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SUP_SUPPLIER_SKEY_1
    AS	
       /*	
       #DescStart#	
       #$Revision: 7426 $, $LastChangedBy: cmarose $	
       #SubjectAreas#: Lieferanten	
       #DescEnd#	
       */	
       SELECT	
         client_id,	
       sup_sid        AS supplier_id,	
       CASE	
           WHEN Substr(src_lifnr,1,1) > '9' THEN Coalesce(LTrim(src_orig_supplier_nr),src_lifnr)	
           ELSE Coalesce(LTrim(src_orig_supplier_nr),Cast(Cast(src_lifnr AS INTEGER) AS VARCHAR(10)))	
        END            AS orig_supplier_nr,	
       dwh_valid_from AS dat_rec_start,	
       dwh_valid_to   AS dat_rec_end	
   FROM p_lew_bil_ac.v_supplier_1	
   WHERE actual_fg_supplier = 1	
;