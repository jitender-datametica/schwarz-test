CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_hydra_praemiengruppe_2 (mandant_id, pers_teilbereich_id,
praemiengrp_id, praemiengrp_bez) AS SELECT mandant_id,
 pers_teilbereich_id,
 COALESCE(CASE
   WHEN praemiengrp_id = ''
   THEN NULL
   ELSE praemiengrp_id
   END, '-1') AS praemiengrp_id,
 COALESCE(CASE
   WHEN praemiengrp_id = ''
   THEN 'fehlende \'\'Kein Pick/BDE PG\'\''
   WHEN praemiengrp_bez = ''
   THEN NULL
   ELSE praemiengrp_bez
   END, 'n/a') AS praemiengrp_bez
FROM kfl_production_dbp_view.v_l_hydra_praemiengruppe_2;