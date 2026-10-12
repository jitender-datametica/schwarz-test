CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_besch_faktura_medata_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.art_id AS art_id,
  v01.dat_faktura AS dat_faktura,
  v02.wup_id AS wup_id,
  v02.nb_id AS nb_id,
  v01.mandant_id AS mandant_id,
  v01.menge_fakturiert AS menge_fakturiert,
  v01.wup_id AS vz_wup_id,
  v01.nb_id AS vz_nb_id,
  v03.gp_id AS gp_id,
  SUBSTR(CASE WHEN NOT v06.posten_id IN ('PN', 'PF', 'SP') THEN 'SO' ELSE 'PN' END, 1, 2) AS posten_kz_per,
  v01.zwsum_3_betrag AS md_faktura_ek_n,
  v01.ek_netto_bnk AS md_ek_netto_bnk,
  v01.zwsum_3_betrag * ROUND(CAST((
    100 + v05.mwst
  ) / 100 AS BIGNUMERIC), 5) AS md_zekp_ek_brutto,
  v01.ek_mep AS md_zekp_ek_mep,
  v01.ek_mep - v01.logistikkostenzuschlag AS md_zekp_ek_mepolk
FROM kfl_production_dbp_view.v_besch_faktura_medata_2 AS v01
INNER JOIN kfl_production_dbp_view.v_wup_2 AS v02
  ON v01.faktura_markt = v02.wup_id AND v01.mandant_id = v02.mandant_id
INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per_2 AS v03
  ON v01.art_id = v03.art_id
  AND v01.mandant_id = v03.mandant_id
  AND v01.dat_faktura BETWEEN v03.dat_von AND v03.dat_bis
INNER JOIN kfl_production_dbp_view.v_art_2 AS v04
  ON v01.art_id = v04.art_id AND v01.mandant_id = v04.mandant_id
INNER JOIN kfl_production_dbp_view.v_mwst_per_2 AS v05
  ON v04.mwst_id = v05.mwst_id
  AND v04.mandant_id = v05.mandant_id
  AND v01.dat_faktura BETWEEN v05.dat_von AND v05.dat_bis
LEFT JOIN kfl_production_dbp_view.v_art_per_2 AS v06
  ON v01.art_id = v06.art_id
  AND v01.mandant_id = v06.mandant_id
  AND v01.dat_faktura BETWEEN DATE_SUB(v06.dat_von, INTERVAL '1' DAY) AND (
    DATE_SUB(v06.dat_bis, INTERVAL '1' DAY)
  )
WHERE
  v01.mandant_id = 1;
