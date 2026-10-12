CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lieferanten_stammkondition_1 AS SELECT mandant_id,
 gp_id,
 einkaufsorganisation_id,
 kondgrp_id,
 dat_von,
 kond_art,
 dat_bis,
 wert,
 prozent
FROM kfl_production_dbp_data.lieferanten_stammkondition_1;