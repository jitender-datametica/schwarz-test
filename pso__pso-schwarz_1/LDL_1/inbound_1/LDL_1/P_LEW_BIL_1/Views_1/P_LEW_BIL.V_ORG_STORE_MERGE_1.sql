CREATE OR REPLACE view P_LEW_BIL.V_ORG_STORE_MERGE_1 as
  /*	
  #DescStart#	
  #$Revision: 6283 $, $LastChangedBy: hwieber $	
  #SubjectAreas#: Organisationsstruktur	
  #DescEnd#	
  */	
   SELECT	
     osm.st_loc_sid                       AS loc_sid_store,	
   osm.client_id,	
   osm.country_cd,	
   osm.dat_opening,	
   osm.dat_real_opening,	
   osm.dat_closing,	
   osm.dat_valid_from,	
   osm.region_cd,	
   osm.object_nr,	
   osm.licence_nr,	
   osm.pst_lang_cd,	
   osm.mde_print_cd,	
   osm.closed_fg,	
   osm.mde_lang_cd,	
   osm.ord_unit_valid_store_cd,	
   osm.test_store_fg,	
   osm.transfer_fg,	
   osm.store_desc,	
   osm.orig_store_nr               AS src_orig_store_nr,	
   osm.wh_loc_sid                  AS loc_sid_wh              --wh.src_wh_id	
   ,	
   osm.cnt_open_days,	
   osm.qty_min_dflt,	
   osm.dat_calc_start_py,	
   osm.dat_calc_end_py,	
   osm.dat_calc_start_ppy,	
   osm.dat_opening_ovis,	
   osm.dat_closing_ovis,	
   osm.objectstatus_id,	
   osm.mis_store_active_fg,	
   osm.move_to_st_loc_sid             AS loc_sid_store_move_to,	
   osm.move_fg,	
   osm.aspect_id	
   FROM p_lew_core_ac.v_wawi_org_store_merge_act_1 osm;