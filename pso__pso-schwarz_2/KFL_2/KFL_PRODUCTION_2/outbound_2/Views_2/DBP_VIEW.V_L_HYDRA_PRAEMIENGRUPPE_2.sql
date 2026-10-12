CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_hydra_praemiengruppe_2 AS SELECT mandant_id,
 pers_teilbereich_id,
 praemiengrp_id,
 praemiengrp_bez
FROM kfl_production_dbp_data.l_hydra_praemiengruppe_2;