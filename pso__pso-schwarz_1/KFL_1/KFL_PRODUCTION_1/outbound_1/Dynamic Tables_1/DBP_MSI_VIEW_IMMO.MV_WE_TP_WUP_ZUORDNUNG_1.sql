CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_immo.mv_we_tp_wup_zuordnung_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  w1.mandant_id AS mandant_id,
  w1.wup_id AS wirtschaftseinheit_id,
  v1.we_intreno AS we_intreno,
  w1.dat_eroeffnung AS dat_eroeffnung,
  w1.dat_von AS dat_von,
  w1.dat_bis AS dat_bis,
  gf1.gf_id AS gf_id,
  gf1.gf_name AS gf_name,
  vs1.vsvt_bez AS vertriebsschiene,
  w1.vkl_id AS vkl_id,
  vkl1.vkl_name AS vkl_name,
  w1.hl_id AS hl_id,
  hl1.hl_name AS hl_name,
  tp2.tp_bl_kbl_name AS bl_bau_einr_name,
  tp2.tp_betreuer_kbl_name AS betreuer_bau_einr_name,
  tp2.tp_ol_vermietung AS ol_vermietung_name,
  tp2.frische_baecker AS frische_baecker,
  tp2.discount_backshop AS discount_backshop,
  v2.backshop_system AS kaufland_baeckerei,
  CASE WHEN v2.bed_fleisch_fg = 1 THEN 'Ja' ELSE 'Nein' END AS fleisch_fg,
  CASE WHEN v2.bed_imbiss_fg = 1 THEN 'Ja' ELSE 'Nein' END AS imbiss_fg,
  CASE
    WHEN v2.bed_fisch_id = 2
    THEN 'SB'
    WHEN v2.bed_fisch_id = 3
    THEN 'Bedienung'
    WHEN v2.bed_fisch_id = 4
    THEN 'Bedienung/SB'
    ELSE '-'
  END AS fisch_fg,
  tp2.eigentum_bez AS eigentum_bez,
  COALESCE(gfp.ginfo_flaeche_netto, 0) AS flaeche_parkplaetze,
  w1.verkaufsflaeche AS verkaufsflaeche,
  w1.betriebsflaeche AS betriebsflaeche
FROM kfl_production_dbp_view.v_wup_1 AS w1
LEFT JOIN kfl_production_dbp_view.v_techn_platz_per_1 AS tp0
  ON w1.mandant_id = tp0.mandant_id
  AND w1.wup_id = tp0.wup_id
  AND tp0.techn_platz_ebene_id = 2
  AND tp0.dat_bis = CAST('9999-12-31' AS DATE)
LEFT JOIN kfl_production_dbp_view.v_techn_platz_ebene_2_per_1 AS tp2
  ON tp0.techn_platz_id = tp2.techn_platz_id
  AND tp2.dat_bis = CAST('9999-12-31' AS DATE)
LEFT JOIN kfl_production_dbp_view.v_ginfo_flaeche_per_1 AS gfp
  ON tp0.techn_platz_id = gfp.techn_platz_id
  AND gfp.ginfo_flaeche_id = 'PPL'
  AND gfp.dat_bis = CAST('9999-12-31' AS DATE)
LEFT JOIN kfl_production_dbp_view.v_hl_1 AS hl1
  ON w1.hl_id = hl1.hl_id AND w1.mandant_id = hl1.mandant_id
LEFT JOIN kfl_production_dbp_view.v_vkl_1 AS vkl1
  ON w1.vkl_id = vkl1.vkl_id AND w1.mandant_id = vkl1.mandant_id
LEFT JOIN kfl_production_dbp_view.v_gf_1 AS gf1
  ON vkl1.gf_id = gf1.gf_id AND vkl1.mandant_id = gf1.mandant_id AND gf1.ek_fg = 0
LEFT JOIN kfl_production_dbp_view.v_vs_1 AS vs1
  ON w1.vs_id = vs1.vs_id AND w1.mandant_id = vs1.mandant_id
LEFT JOIN kfl_production_dbp_msi_view_immo.mv_wirtschaftseinheit_1 AS v1
  ON w1.wup_id = CAST(v1.wirtschaftseinheit_id AS FLOAT64)
  AND w1.mandant_id = v1.mandant_id
LEFT JOIN kfl_production_dbp_msi_v_view.v_wup_denorm_1 AS v2
  ON w1.wup_id = v2.wup_id AND w1.mandant_id = v2.mandant_id
WHERE
  w1.nb_id = 0 AND w1.dat_eroeffnung > PARSE_DATE('%F', '1900-01-01');
