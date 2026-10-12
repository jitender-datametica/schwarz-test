CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_lieferanten_stammkondition (gp_id, kondgrp_id, dat_von, kond_art
, dat_bis, lief_wert, lief_proz) AS SELECT gp_id,
 kondgrp_id,
 dat_von,
 kond_art,
 dat_bis,
 wert AS lief_wert,
 prozent AS lief_proz
FROM kfl_production_dbp_view.v_lieferanten_stammkondition
WHERE mandant_id = 1;