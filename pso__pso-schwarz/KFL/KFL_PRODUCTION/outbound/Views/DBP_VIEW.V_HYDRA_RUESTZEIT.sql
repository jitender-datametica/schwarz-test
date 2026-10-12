CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hydra_ruestzeit AS SELECT mandant_id,
 pers_teilbereich_id,
 dat,
 praemiengrp_id,
 transport_gv_id,
 lagernummer_id,
 ewm_fg,
 dauer_ist,
 dauer_ruest,
 dauer_wechsel,
 dauer_sonstiges,
 abrechnung_fg
FROM kfl_production_dbp_data.hydra_ruestzeit;