CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mandant_grp AS SELECT mandantgrp_id,
 spr_id,
 mandant_grp_bez,
 mandant_grp_bez_kurz,
 td_insert,
 td_update
FROM kfl_production_dbp_data.mandant_grp;