CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_log.mv_dt_kunde_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 30,max_staleness = INTERVAL 30 MINUTE,allow_non_incremental_definition = true
) AS
SELECT wup_id AS kunde_id,
 aktuell_wup_id,
  CASE
  WHEN aktuell_wup_id = wup_id
  THEN 1
  ELSE 0
  END AS is_akt_wup_id_fg,
 mandant_id AS mandant_id_kunde,
 nb_id,
  CASE
  WHEN nb_id = - 1
  THEN '---'
  ELSE wup_standort
  END AS kunde_bez,
 dat_von,
 dat_bis,
 wup_typ_id
FROM kfl_production_dbp_view.v_wup_1 AS V01
WHERE nb_id IN (2, 0, - 111) AND wup_id > 0
 OR nb_id = - 1 AND wup_id = 0
UNION DISTINCT
SELECT kunde_id,
 kunde_id AS aktuell_wup_id,
 1 AS is_akt_wup_id_fg,
 mandant_id_kunde,
 nb_id,
 'B2B' AS kunde_bez,
 MIN(dat_lief_soll) AS dat_von,
 DATE '9999-12-31' AS dat_bis,
 2 AS wup_typ_id
FROM kfl_production_dbp_data.besch_lief_wa_hu_sum_1
WHERE kunde_id > 10000
 AND mandant_id = 8
GROUP BY kunde_id,
 aktuell_wup_id,
 is_akt_wup_id_fg,
 mandant_id_kunde,
 nb_id,
 kunde_bez,
 wup_typ_id;

