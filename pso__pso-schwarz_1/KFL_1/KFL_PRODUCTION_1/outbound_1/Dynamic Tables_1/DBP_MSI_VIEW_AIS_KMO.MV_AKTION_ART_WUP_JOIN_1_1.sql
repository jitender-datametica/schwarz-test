CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_aktion_art_wup_join_1_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.aktion_id AS aktion_id,
  v01.mandant_id AS mandant_id,
  v01.dat_von AS dat_von,
  v01.dat_bis AS dat_bis,
  v03.dat AS dat,
  v02.vk_aktion_brutto AS vk_aktion_brutto,
  v02.art_id AS art_id,
  v02.wup_id AS wup_id,
  v02.nb_id AS nb_id,
  v01.aktionsart_id AS aktionsart_id,
  CASE WHEN v01.preisaktiviert_fg = 1 THEN 'X' ELSE ' ' END AS preisaktivierung,
  v02.aktion_thema_id AS aktion_thema_id
FROM kfl_production_dbp_view.v_aktion_1 AS v01
INNER JOIN kfl_production_dbp_view.v_aktion_art_wup_zu_1 AS v02
  ON v01.aktion_id = v02.aktion_id AND v01.mandant_id = v02.mandant_id
INNER JOIN kfl_production_dbp_view.v_tag_1 AS v03
  ON v03.dat BETWEEN v01.dat_von AND v01.dat_bis
WHERE
  v02.grund_sperrung IS NULL
  AND v01.mandant_id <> 1
  AND v03.akt_kj BETWEEN -3 AND 0
  AND v02.dat_preisaktiviert <> CAST('1900-01-01' AS DATE);