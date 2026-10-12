CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_wup_grp_zu_1 (mandant_id, nb_id, referenzierend, referenziert,
wup_id, wup_grp_id) AS SELECT mandant_id,
 nb_id,
 referenzierend,
 referenziert,
 wup_id,
 wupgrp_id AS wup_grp_id
FROM kfl_production_dbp_view.v_wup_grp_zu_1
WHERE mandant_id = 1;