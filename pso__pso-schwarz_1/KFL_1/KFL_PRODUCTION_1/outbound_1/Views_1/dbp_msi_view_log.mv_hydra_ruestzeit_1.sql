CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_hydra_ruestzeit_1 (mandant_id, pers_teilbereich_id, dat,
praemiengrp_id, transport_gv_id, lagernummer_id, artikelsortiment_id, ewm_fg, dauer_ist, dauer_ruest, dauer_wechsel,
dauer_sonstiges, abrechnung_fg) AS SELECT HR.mandant_id,
 HR.pers_teilbereich_id,
 HR.dat,
 COALESCE(CASE
   WHEN HR.praemiengrp_id = ''
   THEN NULL
   ELSE HR.praemiengrp_id
   END, '-1') AS praemiengrp_id,
 COALESCE(HR.transport_gv_id, '-1') AS transport_gv_id,
 COALESCE(HR.lagernummer_id, '-1') AS lagernummer_id,
 COALESCE(ART_SORT.artikelsortiment_id, '-1') AS artikelsortiment_id,
 COALESCE(HR.ewm_fg, - 1) AS ewm_fg,
 HR.dauer_ist,
 HR.dauer_ruest,
 HR.dauer_wechsel,
 HR.dauer_sonstiges,
 HR.abrechnung_fg
FROM kfl_production_dbp_view.v_hydra_ruestzeit_1 AS HR
 LEFT JOIN kfl_production_dbp_msi_v_view.v_ts_lagernummer_sortierung_scm_1 AS ART_SORT ON HR.lagernummer_id = ART_SORT.lagernummer_id
    AND HR.mandant_id = ART_SORT.mandant_id;