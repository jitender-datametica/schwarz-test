CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_mandant_grp_zu_1 (mandantgrp_id, mandant_id) AS SELECT
 mandantgrp_id,
 mandant_id
FROM kfl_production_dbp_view.v_mandant_grp_zu_1
WHERE mandant_id = 1;