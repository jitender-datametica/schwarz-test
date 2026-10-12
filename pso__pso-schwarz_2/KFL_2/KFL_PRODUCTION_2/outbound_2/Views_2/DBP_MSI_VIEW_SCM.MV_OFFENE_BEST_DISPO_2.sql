CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_offene_best_dispo_2 AS
SELECT
  mandant_id,
  wup_id,
  nb_id,
  gp_id,
  art_id,
  MAX(CASE WHEN rn = 1 THEN dat_lief ELSE NULL END) AS dat_lief_next_dispo,
  CAST(NULL AS DATE) AS dat_lief_max_dispo,
  SUM(menge_best_bme) AS menge_best_bme_offen_dispo,
  SUM(menge_best_kolli) AS menge_best_kolli_offen_dispo,
  SUM(anz_best_pos) AS anz_best_pos_dispo,
  DATE_DIFF(CAST(NULL AS DATE), MAX(CASE WHEN rn = 1 THEN dat_lief ELSE NULL END), DAY) AS diff_tage_dispo,
  SUM(CASE WHEN rn = 1 THEN menge_best_bme ELSE NULL END) AS menge_best_bme_offen_next_dispo,
  SUM(CASE WHEN rn = 1 THEN menge_best_kolli ELSE NULL END) AS menge_best_kolli_offen_next_dispo
FROM (
  SELECT
    mandant_id,
    wup_id,
    nb_id,
    gp_id,
    art_id,
    dat_lief,
    menge_best_bme,
    menge_best_kolli,
    anz_best_pos,
    ROW_NUMBER() OVER (
      PARTITION BY mandant_id, wup_id, nb_id, gp_id, art_id 
      ORDER BY dat_lief ASC
    ) AS rn
  FROM (
    SELECT
      mandant_id,
      wup_id,
      nb_id,
      gp_id,
      ROUND(CAST(art_id AS BIGNUMERIC), 0) AS art_id,
      dat_lief,
      SUM(CAST(menge_best_gesamt AS NUMERIC)) AS menge_best_bme,
      SUM(CAST(menge_best_gesamt AS NUMERIC) / umrech_faktor_best_bme) AS menge_best_kolli,
      COUNT(*) AS anz_best_pos
    FROM kfl_production_dbp_view.v_vz_best_vor_2
    WHERE dat_lief >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)
      AND dat_plan = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY)
    GROUP BY
      mandant_id,
      wup_id,
      nb_id,
      gp_id,
      ROUND(CAST(art_id AS BIGNUMERIC), 0),
      dat_lief
  ) t_agg
) t_ranked
GROUP BY
  mandant_id,
  wup_id,
  nb_id,
  gp_id,
  art_id;