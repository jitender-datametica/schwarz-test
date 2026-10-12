CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_consolidationgroup_1 (client_id, wh_loc_sid, itm_consgrp_id,
dat_rec_start, dat_rec_end, itm_consgrp_desc, dat_modification, timestamp_fn, load_id) AS SELECT client_id,
 wh_loc_sid,
 itm_consgrp_id,
 dat_rec_start,
 dat_rec_end,
 itm_consgrp_desc,
 dat_modification,
 timestamp_fn,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_consolidationgroup_1;