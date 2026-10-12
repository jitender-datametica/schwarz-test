CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_fur_prognose
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.wup_id AS wup_id,
  v01.nb_id AS nb_id,
  v01.mandant_id AS mandant_id,
  v01.art_id AS art_id,
  v01.dat AS dat,
  CAST(v01.menge_prognose AS NUMERIC) AS menge_prognose,
  ROUND(CAST(v01.menge_prognose * COALESCE(v04.umrech_faktor, 1) AS NUMERIC), 3) AS menge_prognose_kolli,
  CAST(v01.menge_prognose_bef AS NUMERIC) AS menge_prognose_bef,
  ROUND(CAST(v01.menge_prognose_bef * COALESCE(v04.umrech_faktor, 1) AS NUMERIC), 3) AS menge_prognose_bef_kolli,
  CAST(v01.menge_prognose_max AS NUMERIC) AS menge_prognose_max,
  ROUND(CAST(v01.menge_prognose_max * COALESCE(v04.umrech_faktor, 1) AS NUMERIC), 3) AS menge_prognose_max_kolli,
  CAST(v01.menge_ofc AS NUMERIC) AS menge_ofc,
  ROUND(CAST(v01.menge_ofc * COALESCE(v04.umrech_faktor, 1) AS NUMERIC), 3) AS menge_ofc_kolli,
  v02.gp_id AS gp_id,
  v01.progn_groesser_fg AS progn_groesser_fg,
  v01.menge_af_groesser_fg AS menge_af_groesser_fg
FROM kfl_production_dbp_view.v_fur_prognose AS v01
INNER JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per AS v02
  ON v01.art_id = v02.art_id
  AND v01.mandant_id = v02.mandant_id
  AND v01.wup_id = v02.wup_id
  AND v01.dat BETWEEN v02.dat_von AND v02.dat_bis
INNER JOIN kfl_production_dbp_view.v_art AS v021
  ON v01.mandant_id = v021.mandant_id
  AND v01.art_id = v021.art_id
  AND v021.dat_bis = PARSE_DATE('%F', '9999-12-31')
LEFT JOIN kfl_production_dbp_view.v_art_vorschlagswert_per AS v03
  ON v021.mandant_id = v03.mandant_id
  AND v021.art_id = v03.art_id
  AND v03.dat_bis = PARSE_DATE('%F', '9999-12-31')
LEFT JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per AS v04
  ON v03.mandant_id = v04.mandant_id
  AND v03.art_id = v04.art_id
  AND v03.ausg_menge_einh_id = v04.altnv_menge_einh_id
  AND v04.dat_bis = PARSE_DATE('%F', '9999-12-31')
WHERE
  v01.mandant_id = 1
  AND v01.dispomerkmal IN ('10', '11', '12', '14')
  AND v01.listung_id = 1
  AND v01.kdis = 0;
