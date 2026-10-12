CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ORG_STORE_DESC_2 as
              /*	
              #DescStart#	
              #$Revision: 6699 $, $LastChangedBy: hwieber $	
              #SubjectAreas#: Organisationsstruktur	
              #DescEnd#	
              */	
              SELECT	
                loc_sid_store                AS store_id,	
              client_id                    AS client_id,	
              src_orig_store_nr            AS orig_store_nr,	
              Coalesce(loc_name2,loc_name) AS store_desc	
 FROM p_lew_bil_ac.v_store_2	
 WHERE	
                 dwh_actual_fg = 1           -- Aktueller Datensatz	
                 AND  pseudo_store_fg = 0	
;