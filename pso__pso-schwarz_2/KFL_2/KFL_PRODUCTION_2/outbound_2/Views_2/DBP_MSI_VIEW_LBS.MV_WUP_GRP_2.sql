CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_wup_grp_2 (wupgrp_id, wupgrp_bez, wupgrptyp_id) AS SELECT
 wupgrp_id,
 wupgrp_bez,
 wupgrptyp_id
FROM kfl_production_dbp_view.v_wup_grp_2;