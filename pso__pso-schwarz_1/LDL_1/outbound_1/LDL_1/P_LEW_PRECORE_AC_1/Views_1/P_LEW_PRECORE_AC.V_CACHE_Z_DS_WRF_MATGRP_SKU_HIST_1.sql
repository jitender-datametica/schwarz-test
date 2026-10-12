CREATE OR REPLACE VIEW ldl_p_lew_precore_ac.v_cache_z_ds_wrf_matgrp_sku_hist_1 (client_id, bic_zmlila, hier_id, matnr,
node, date_from, date_to, mainflg, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 bic_zmlila,
 hier_id,
 matnr,
 node,
 date_from,
 date_to,
 mainflg,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_precore.t_cache_z_ds_wrf_matgrp_sku_hist_1;