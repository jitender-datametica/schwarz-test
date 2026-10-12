CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_besch_best_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 best_beleg_id,
 gp_id,
 dat_best_beleg,
 bestellart_id,
 best_beleg_status_id,
 loesch_fg,
 nachbest_fg,
 einkaufsorganisation_id,
 dat_aenderung,
 kunde_id,
 wup_id,
 nb_id,
 7 AS system_id,
 EXTRACT(YEAR FROM dat_best_beleg) AS kj,
 submi_id,
 ref_beleg_id_intern
FROM kfl_production_dbp_view.v_besch_best_1
WHERE mandant_id = 1
 AND einkaufsorganisation_id <> 5000;