CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_purchase_group_1 (client_id, pur_grp_sid, src_ekgrp, pur_grp_name, dwh_load_id
, dwh_created, dwh_updated) AS SELECT client_id,
 pur_grp_sid,
 src_ekgrp,
 pur_grp_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_purchase_group_1;