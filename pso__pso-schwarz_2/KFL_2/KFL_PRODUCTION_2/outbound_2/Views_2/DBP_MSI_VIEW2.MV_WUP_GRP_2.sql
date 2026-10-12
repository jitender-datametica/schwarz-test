CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_wup_grp_2 (wup_grp_id, wup_grp_bez, wup_grp_typ_id) AS SELECT
 wupgrp_id AS wup_grp_id,
 wupgrp_bez AS wup_grp_bez,
 wupgrptyp_id AS wup_grp_typ_id
FROM kfl_production_dbp_view.v_wup_grp_2;