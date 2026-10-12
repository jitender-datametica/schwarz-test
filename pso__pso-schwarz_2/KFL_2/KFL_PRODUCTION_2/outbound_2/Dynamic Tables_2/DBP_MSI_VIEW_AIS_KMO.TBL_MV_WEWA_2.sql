CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_wewa_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
/* ZEKP_2 Auflösung, marktspezifische Preise */ /* ZEKP_2 Auflösung allgemeingeltende Preise */
SELECT
  v01.mandant_id AS mandant_id,
  v01.wewa_beleg_id AS wewa_beleg_id,
  v01.wewa_beleg_pos_id AS wewa_beleg_pos_id,
  v01.wewa_jahr AS wewa_jahr,
  v01.art_id AS art_id,
  v01.wup_id AS wup_id,
  v01.nb_id AS nb_id,
  v01.gp_id AS gp_id,
  v01.lager_bewart_id AS lager_bewart_id,
  v01.dat_buch AS dat_buch,
  v01.menge_basis AS menge_basis,
  v01.status_2 AS wewa_status,
  v01.wrg_id AS wrg_id,
  v01.betrag_ek_netto AS betrag_ek_netto,
  v01.betrag_vk_netto AS betrag_vk_netto,
  v01.konditionsbetrag_zar5 AS konditionsbetrag_zar5,
  v02.einstandspreis AS einstandspreis_v02,
  v02.ek_brutto AS ek_brutto_v02,
  v02.ek_brutto_normal AS ek_brutto_normal_v02,
  v02.ek_nettonetto AS ek_nettonetto_v02,
  v02.ek_mep_vor_fwu AS ek_mep_vor_fwu_v02,
  v02.ek_mep AS ek_mep_v02,
  v02.ek_kal_basis AS ek_kalkulationsbasis_v02,
  v02.ek_kal_basis + (
    v02.ek_mep_vor_fwu - v02.ek_mep
  ) AS ek_kalkulationsbasis_ohne_fwu_v02,
  v03.einstandspreis AS einstandspreis_v03,
  v03.ek_brutto AS ek_brutto_v03,
  v03.ek_brutto_normal AS ek_brutto_normal_v03,
  v03.ek_nettonetto AS ek_nettonetto_v03,
  v03.ek_mep_vor_fwu AS ek_mep_vor_fwu_v03,
  v03.ek_mep AS ek_mep_v03,
  v03.ek_kal_basis AS ek_kalkulationsbasis_v03,
  v03.ek_kal_basis + (
    v03.ek_mep_vor_fwu - v03.ek_mep
  ) AS ek_kalkulationsbasis_ohne_fwu_v03,
  v300.umrechnungskurs AS umrechnungskurs_0,
  v400.umrechnungskurs AS umrechnungskurs_1,
  SUBSTR(CASE WHEN NOT v04.posten_id IN ('1') THEN 'SO' ELSE 'PN' END, 1, 2) AS posten_kz_per
FROM kfl_production_dbp_data.wewa_2 AS v01
LEFT JOIN (
  SELECT
    mandant_id,
    art_id,
    gp_id,
    wup_id,
    dat_von,
    dat_bis,
    einstandspreis,
    ek_nettonetto,
    ek_mep_vor_fwu,
    ek_mep,
    ek_kal_basis,
    ek_brutto,
    ek_brutto_normal
  FROM kfl_production_dbp_data.art_gp_wup_zu_per_2
  WHERE
    mandant_id > 1 AND wup_id > -1
) AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.wup_id = v02.wup_id
  AND v01.gp_id = v02.gp_id
  AND v01.art_id = v02.art_id
  AND v01.dat_buch BETWEEN v02.dat_von AND v02.dat_bis
LEFT JOIN (
  SELECT
    mandant_id,
    art_id,
    gp_id,
    wup_id,
    dat_von,
    dat_bis,
    einstandspreis,
    ek_nettonetto,
    ek_mep_vor_fwu,
    ek_mep,
    ek_kal_basis,
    ek_brutto,
    ek_brutto_normal
  FROM kfl_production_dbp_data.art_gp_wup_zu_per_2
  WHERE
    mandant_id > 1 AND wup_id = -1
) AS v03
  ON v01.mandant_id = v03.mandant_id
  AND v01.gp_id = v03.gp_id
  AND v01.art_id = v03.art_id
  AND v01.dat_buch BETWEEN v03.dat_von AND v03.dat_bis
/* Umrechnung Standardkurs, Tageskurs
   JOIN KFL_PRODUCTION.dbp_view.v_kurs_2 v300
   ON v01.dat_buch BETWEEN v300.dat_von AND v300.dat_bis
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR' */ /* CROSS JOIN aktueller Berichtskurs */
INNER JOIN kfl_production_dbp_data.kurs_2 AS v300
  ON v300.dat_bis = CAST('9999-12-31' AS DATE)
  AND v01.wrg_id = v300.von_wrg_id
  AND v300.kurstyp_id = 3
  AND v300.nach_wrg_id = 'EUR' /* CROSS JOIN historischer Berichtskurs */
INNER JOIN kfl_production_dbp_data.kurs_2 AS v400
  ON v01.dat_buch BETWEEN v400.dat_von AND v400.dat_bis
  AND v01.wrg_id = v400.von_wrg_id
  AND v400.kurstyp_id = 3
  AND v400.nach_wrg_id = 'EUR'
LEFT JOIN kfl_production_dbp_data.art_per_2 AS v04
  ON v01.art_id = v04.art_id
  AND v01.mandant_id = v04.mandant_id
  AND v01.dat_buch BETWEEN DATE_SUB(v04.dat_von, INTERVAL '1' DAY) AND (
    DATE_SUB(v04.dat_bis, INTERVAL '1' DAY)
  )
WHERE
  v01.mandant_id <> 1;
