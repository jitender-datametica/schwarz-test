CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ORG_STORE_SKEY as
   SELECT	
     client_id,	
   loc_sid_store     AS store_id,	
   src_wh_id         AS wh_id,	
   src_orig_store_nr AS orig_store_nr	
  FROM p_lew_bil_ac.v_store_to_warehouse_lastknown	
;