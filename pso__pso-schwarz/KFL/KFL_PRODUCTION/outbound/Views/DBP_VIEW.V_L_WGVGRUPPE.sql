CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_wgvgruppe AS SELECT wgvgrp_id,
 mandant_id,
 wup_id,
 nb_id
FROM kfl_production_dbp_data.l_wgvgruppe;