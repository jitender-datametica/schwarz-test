CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_bsch_rech_det
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.bsch_id AS bsch_id,
  v01.bsch_pos_id AS bsch_pos_id,
  v01.art_id AS art_id,
  v01.dat AS dat,
  v01.bewart_id AS bewart_id,
  v01.mandant_id AS mandant_id,
  v01.nb_id AS nb_id,
  v01.gp_id AS gp_id,
  v01.ba_id AS ba_id,
  v01.ba_pos_id AS ba_pos_id,
  v01.menge_rech AS menge_rech,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    THEN v01.menge_rech
    ELSE 0
  END AS bsch_menge,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    AND v01.nb_id = -111
    THEN v01.menge_rech
    ELSE 0
  END AS bsch_menge_zl,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    AND v01.nb_id IN (0)
    THEN v01.menge_rech
    ELSE 0
  END AS bsch_menge_dz,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (161, 162, 907, 908, 912, 916)
    THEN v01.menge_rech
    ELSE 0
  END AS bsch_menge_ret,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (161, 162, 907, 908, 912, 916)
    AND v01.nb_id = -111
    THEN v01.menge_rech
    ELSE 0
  END AS bsch_menge_ret_zl,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (161, 162, 907, 908, 912, 916)
    AND v01.nb_id IN (0)
    THEN v01.menge_rech
    ELSE 0
  END AS bsch_menge_ret_dz,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    THEN v01.ek_n
    ELSE 0
  END AS lief_ek_n_umsatz,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    AND v01.nb_id = -111
    THEN v01.ek_n
    ELSE 0
  END AS lief_ek_n_umsatz_zl,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    AND v01.nb_id IN (0)
    THEN v01.ek_n
    ELSE 0
  END AS lief_ek_n_umsatz_dz,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (161, 162, 907, 908, 912, 916)
    THEN v01.ek_n
    ELSE 0
  END AS lief_ek_n_umsatz_ret,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (161, 162, 907, 908, 912, 916)
    AND v01.nb_id = -111
    THEN v01.ek_n
    ELSE 0
  END AS lief_ek_n_umsatz_ret_zl,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (161, 162, 907, 908, 912, 916)
    AND v01.nb_id IN (0)
    THEN v01.ek_n
    ELSE 0
  END AS lief_ek_n_umsatz_ret_dz,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    THEN v01.ek_nn
    ELSE 0
  END AS lief_ek_nn_umsatz,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    AND v01.nb_id = -111
    THEN v01.ek_nn
    ELSE 0
  END AS lief_ek_nn_umsatz_zl,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    AND v01.nb_id IN (0)
    THEN v01.ek_nn
    ELSE 0
  END AS lief_ek_nn_umsatz_dz,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (161, 162, 907, 908, 912, 916)
    THEN v01.ek_nn
    ELSE 0
  END AS lief_ek_nn_umsatz_ret,
  v01.ek_n AS ek_n,
  v01.ek_nn AS ek_nn,
  v01.ek_kb AS ek_kb,
  v01.ek_mep AS ek_mep,
  v01.status AS status,
  v01.vk_n AS lief_vk_n_umsatz,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    THEN v01.ek_kb
    ELSE 0
  END AS lief_ek_kb_umsatz,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    AND v01.nb_id = -111
    THEN v01.ek_kb
    ELSE 0
  END AS lief_ek_kb_umsatz_zl,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    AND v01.nb_id IN (0)
    THEN v01.ek_kb
    ELSE 0
  END AS lief_ek_kb_umsatz_dz,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (161, 162, 907, 908, 912, 916)
    THEN v01.ek_kb
    ELSE 0
  END AS lief_ek_kb_umsatz_ret,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    THEN v01.ek_mep
    ELSE 0
  END AS lief_ek_mep_umsatz,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    AND v01.nb_id = -111
    THEN v01.ek_mep
    ELSE 0
  END AS lief_ek_mep_umsatz_zl,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (101, 102, 901, 902, 905, 906, 913, 915)
    AND v01.nb_id IN (0)
    THEN v01.ek_mep
    ELSE 0
  END AS lief_ek_mep_umsatz_dz,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (161, 162, 907, 908, 912, 916)
    THEN v01.ek_mep
    ELSE 0
  END AS lief_ek_mep_umsatz_ret,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (161, 162, 907, 908, 912, 916)
    AND v01.nb_id = -111
    THEN v01.ek_mep
    ELSE 0
  END AS lief_ek_mep_umsatz_ret_dz,
  CASE
    WHEN CAST(v01.lager_bewart_id AS INT64) IN (161, 162, 907, 908, 912, 916)
    AND v01.nb_id IN (0)
    THEN v01.ek_mep
    ELSE 0
  END AS lief_ek_mep_umsatz_ret_zl,
  v01.logkosten AS logkosten,
  v01.lager_bewart_id AS lager_bewart_id,
  v01.wup_id AS wup_id,
  v01.lagerort_id AS lagerort_id,
  v01.gp_id AS beleg_gp_id,
  SUBSTR(CASE WHEN NOT v2.posten_id IN ('PN', 'PF', 'SP') THEN 'SO' ELSE 'PN' END, 1, 2) AS posten_kz_per
FROM kfl_production_dbp_view.v_bsch_rech_det AS v01
LEFT JOIN kfl_production_dbp_view.v_art_per AS v2
  ON v01.art_id = v2.art_id
  AND v01.mandant_id = v2.mandant_id
  AND v01.dat BETWEEN DATE_SUB(v2.dat_von, INTERVAL '1' DAY) AND (
    DATE_SUB(v2.dat_bis, INTERVAL '1' DAY)
  )
WHERE
  v01.mandant_id = 1 AND v01.status <> 2 AND NOT v01.nb_id IN (2, 6, 7);
