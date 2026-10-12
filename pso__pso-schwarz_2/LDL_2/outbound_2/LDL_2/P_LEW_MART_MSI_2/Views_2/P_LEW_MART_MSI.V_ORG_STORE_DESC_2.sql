/* #DescStart#	
              #$Revision: 6699 $, $LastChangedBy: hwieber $	
              #SubjectAreas#: Organisationsstruktur	
              #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_org_store_desc_2 AS SELECT loc_sid_store AS store_id,
 client_id,
 src_orig_store_nr AS orig_store_nr,
 COALESCE(loc_name2, loc_name) AS store_desc
FROM ldl_p_lew_bil_ac.v_store_2
WHERE dwh_actual_fg = 1 -- Aktueller Datensatz

 AND pseudo_store_fg = 0;