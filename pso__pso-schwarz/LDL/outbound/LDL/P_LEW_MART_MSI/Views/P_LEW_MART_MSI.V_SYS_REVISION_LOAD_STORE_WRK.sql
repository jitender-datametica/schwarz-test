/* #DescStart#	
         #$Revision: 9157 $, $LastChangedBy: aarnold $	
         #SubjectAreas#: Access Layer	
         #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_sys_revision_load_store_wrk (client_id, wh_id, store_id, orig_store_nr,
dat_formdate_from, dat_formdate_until, load_in_progress_fg) AS SELECT WRK.client_id,
 WH.src_wh_id AS wh_id,
 WRK.st_loc_sid AS store_id,
 WRK.orig_store_nr,
 WRK.dat_formdate_from,
 WRK.dat_formdate_until,
 WRK.load_in_progress_fg
FROM ldl_p_lew_mart_msi.t_msi_sys_revision_load_store_wrk AS WRK
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON WRK.client_id = WH.client_id AND WRK.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1;