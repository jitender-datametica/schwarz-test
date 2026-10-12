CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_grp_zu_1 AS SELECT wup_id,
 mandant_id,
 nb_id,
 wupgrp_id,
 referenziert,
 referenzierend
FROM kfl_production_dbp_data.wup_grp_zu_1;