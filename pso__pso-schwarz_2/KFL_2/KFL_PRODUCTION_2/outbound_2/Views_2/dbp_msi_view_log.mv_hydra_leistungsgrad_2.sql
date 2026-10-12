CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_hydra_leistungsgrad_2 (mandant_id, pers_teilbereich_id, dat,
lohnart_id, zeitart_id, praemiengrp_id, transport_gv_id, lagernummer_id, artikelsortiment_id, ewm_fg, dauer_ist,
dauer_soll, grad_leistung, menge, abrechnung_fg) AS SELECT HL.mandant_id,
 HL.pers_teilbereich_id,
 HL.dat,
 HL.lohnart_id,
 HL.zeitart_id,
 COALESCE(CASE
   WHEN HL.praemiengrp_id = ''
   THEN NULL
   ELSE HL.praemiengrp_id
   END, '-1') AS praemiengrp_id,
 COALESCE(HL.transport_gv_id, '-1') AS transport_gv_id,
 COALESCE(HL.lagernummer_id, '-1') AS lagernummer_id,
 COALESCE(ART_SORT.artikelsortiment_id, '-1') AS artikelsortiment_id,
 COALESCE(HL.ewm_fg, - 1) AS ewm_fg,
 HL.dauer_ist,
 HL.dauer_soll,
 HL.grad_leistung,
 HL.menge,
 HL.abrechnung_fg
FROM kfl_production_dbp_view.v_hydra_leistungsgrad_2 AS HL_2
 LEFT JOIN kfl_production_dbp_msi_v_view.v_ts_lagernummer_sortierung_scm_2 AS ART_SORT ON HL.lagernummer_id = ART_SORT.lagernummer_id
    AND HL.mandant_id = ART_SORT.mandant_id;