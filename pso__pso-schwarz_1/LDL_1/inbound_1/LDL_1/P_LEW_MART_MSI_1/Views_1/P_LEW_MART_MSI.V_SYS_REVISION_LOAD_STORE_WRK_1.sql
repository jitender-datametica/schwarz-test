CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SYS_REVISION_LOAD_STORE_WRK_1
         /*	
         #DescStart#	
         #$Revision: 9157 $, $LastChangedBy: aarnold $	
         #SubjectAreas#: Access Layer	
         #DescEnd#	
         */	
         (	
            client_id	
           ,wh_id	
           ,store_id	
           ,orig_store_nr	
           ,dat_formdate_from	
           ,dat_formdate_until	
           ,load_in_progress_fg	
         )	
         AS	
            SELECT	
               wrk.client_id	
            ,wh.src_wh_id AS wh_id
            ,wrk.st_loc_sid AS store_id
            ,wrk.orig_store_nr
            ,wrk.dat_formdate_from	
            ,wrk.dat_formdate_until	
            ,wrk.load_in_progress_fg	
            FROM p_lew_mart_msi.t_msi_sys_revision_load_store_wrk_1 wrk	
            INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh	
            ON wh.client_id = wrk.client_id	
            AND wh.loc_sid_wh = wrk.wh_loc_sid	
            AND wh.dwh_actual_fg = 1	
;