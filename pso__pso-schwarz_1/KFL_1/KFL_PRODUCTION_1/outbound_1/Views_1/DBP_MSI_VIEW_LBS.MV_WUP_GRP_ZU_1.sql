CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_wup_grp_zu_1 (wup_id, nb_id, mandant_id, wupgrp_id, referenziert
, referenzierend) AS SELECT wup_id,
 nb_id,
 mandant_id,
 wupgrp_id,
 referenziert,
 referenzierend
FROM kfl_production_dbp_view.v_wup_grp_zu_1;