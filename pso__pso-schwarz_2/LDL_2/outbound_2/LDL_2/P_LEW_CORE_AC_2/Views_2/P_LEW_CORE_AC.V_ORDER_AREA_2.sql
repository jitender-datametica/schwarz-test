CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_order_area_2 (client_id, order_area_sid, src_ekgrp, src_bestbereichnr,
order_area_nr, order_area_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 order_area_sid,
 src_ekgrp,
 src_bestbereichnr,
 order_area_nr,
 order_area_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_order_area_2;