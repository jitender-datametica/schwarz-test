CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_aktion_art_wup_join
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.aktion_id AS aktion_id,
  v01.mandant_id AS mandant_id,
  v01.dat_von AS dat_von,
  v01.dat_bis AS dat_bis,
  v05.kjwo AS kjwo,
  v02.vk_aktion_brutto AS vk_aktion_brutto,
  v02.art_id AS art_id,
  v02.wup_id AS wup_id,
  v02.nb_id AS nb_id,
  v06.vk_brutto AS vk_brutto,
  v01.aktionsart_id AS aktionsart_id,
  v07.sap_werbe_kat_id AS sap_werbe_kat_id,
  CASE WHEN v01.preisaktiviert_fg = 1 THEN 'x' ELSE ' ' END AS preisaktivierung,
  v02.aktion_thema_id AS aktion_thema_id,
  v07.werbe_kat_id AS werbe_kat_id
FROM kfl_production_dbp_view.v_aktion AS v01
INNER JOIN kfl_production_dbp_view.v_aktion_art_wup_zu AS v02
  ON v01.aktion_id = v02.aktion_id AND v01.mandant_id = v02.mandant_id
INNER JOIN kfl_production_dbp_view.v_tag AS v03
  ON v01.dat_von = v03.dat
INNER JOIN kfl_production_dbp_view.v_tag AS v04
  ON v01.dat_bis = v04.dat
INNER JOIN kfl_production_dbp_view.v_woche AS v05
  ON v05.kjwo BETWEEN v03.kjwo AND v04.kjwo
INNER JOIN kfl_production_dbp_view.v_art_wup_zu_per AS v06
  ON v02.art_id = v06.art_id
  AND v02.mandant_id = v06.mandant_id
  AND v02.wup_id = v06.wup_id
  AND v02.nb_id = v06.nb_id
  AND v01.dat_von >= v06.dat_von
  AND v01.dat_von <= v06.dat_bis
INNER JOIN kfl_production_dbp_view.v_l_werbekat AS v07
  ON v01.werbe_kat_id = v07.werbe_kat_id
WHERE
  v02.grund_sperrung IS NULL AND v01.mandant_id = 1;
