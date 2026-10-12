CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_store_group (client_id, store_grp_sid, src_wh_nr, src_store_grp_id,
src_storgrp_id, store_grp_type_cd, campaign_store_grp_type_cd, store_grp_nr, store_grp_name, store_grp_descr, loc_sid_wh
, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 store_grp_sid,
 src_wh_nr,
 src_store_grp_id,
 src_storgrp_id,
 store_grp_type_cd,
 campaign_store_grp_type_cd,
 store_grp_nr,
 store_grp_name,
 store_grp_descr,
 loc_sid_wh,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_store_group;