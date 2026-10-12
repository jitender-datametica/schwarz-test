CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_item_consolidation_2 (client_id, wh_loc_sid, item_sid, dat_rec_start,
dat_rec_end, itm_consgrp_id, dat_modification, timestamp_fn, load_id) AS SELECT client_id,
 wh_loc_sid,
 item_sid,
 dat_rec_start,
 dat_rec_end,
 itm_consgrp_id,
 dat_modification,
 timestamp_fn,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_item_consolidation_2;