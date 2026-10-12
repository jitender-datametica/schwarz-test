CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ORG_STORE_DAYCOUNT as
           /*	
           #DescStart#	
           #$Revision: 6244 $, $LastChangedBy: hwieber $	
           #SubjectAreas#: Organisationsstruktur	
           #DescEnd#	
           */	
           SELECT	
                st_loc_sid               AS store_id,	
           client_id,	
           dat_formdate,	
           dat_last_update,	
           wawi_data_fg,	
           ejr_data_fg,	
           txj_data_fg,	
           art_data_fg	
           FROM p_lew_core_ac.v_wawi_org_store_daycount;