CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wup_2 AS SELECT T0.wup_id,
  CASE
  WHEN T0.wup_id = - 1
  THEN 0
  ELSE T0.nb_id
  END AS nb_id,
 T0.mandant_id,
 T0.land_id,
 T0.dat_von,
 T0.wup_typ_id,
 T0.wup_name_v,
 T0.wup_name_e,
 T0.wup_standort,
 T0.wup_plz,
 T0.wup_str,
 T0.vf_id,
 T0.vkl_id,
 T0.hl_id,
 T0.dat_bis,
 T0.uebernahme_von,
 T0.breakevenumsatz,
 T0.systemrentabilitaet,
 T0.verkaufsflaeche,
 T0.betriebsflaeche,
 T0.fleischsystem,
 T0.preiskategorie_food,
 T0.preiskategorie_nonfood,
 T0.sortkategorie_food,
 T0.sortkategorie_nonfood,
 T0.sondermarkt,
 T0.ref_wup_id,
 T0.wm_id,
 T0.kassentyp,
 T0.dat_qbm_umstellung,
 T0.lead_mwst,
 T0.region_id,
 T0.kundenfaktor,
 T0.vz_wup_id,
  CASE
  WHEN T0.dat_qbm_umstellung IS NOT NULL
  THEN 1
  ELSE 0
  END AS qbm_id,
 T0.getraenkemarkt_fg,
  CASE
  WHEN T0.mandant_id <> 1 AND T0.vs_id IS NULL
  THEN 0
  WHEN T0.mandant_id = 1 AND T0.wup_id = 6902
  THEN 3
  WHEN T0.mandant_id = 1 AND T0.wup_id = 6903
  THEN 1
  WHEN T0.mandant_id = 1 AND T0.wup_id = 6905
  THEN 2
  WHEN T0.mandant_id = 1 AND T0.wup_id = 6906
  THEN 7
  WHEN T0.mandant_id = 1 AND T0.wup_id = 6908
  THEN 6
  WHEN T0.mandant_id = 1 AND T0.wup_id = 6909
  THEN 8
  ELSE T0.vs_id
  END AS vs_id,
 T0.buchungskreis_id,
 T0.verkaufsorganisation_id,
 T0.breitengrad,
 T0.laengengrad,
 T1.frische_manager_id
FROM kfl_production_dbp_view.v_wup_2 AS T0
 LEFT JOIN kfl_production_dbp_msi_v_view.v_wup_denorm_2 AS T1_2 ON T0.mandant_id = T1.mandant_id AND T0.wup_id = T1.wup_id
WHERE T0.nb_id = - 111
UNION ALL
SELECT - 9 AS wup_id,
 - 111 AS nb_id,
 mandant_id,
 mandant_kbez AS land_id,
 DATE '1900-01-01' AS dat_von,
 2 AS wup_typ_id,
 '' AS wup_name_v,
 'Dezentral / Decentral' AS wup_name_e,
 'Dezentral / Decentral' AS wup_standort,
 '00000' AS wup_plz,
 '' AS wup_str,
 0 AS vf_id,
 - 1 AS vkl_id,
 CAST(NULL AS BIGNUMERIC) AS hl_id,
 DATE '9999-12-31' AS dat_bis,
 '' AS uebernahme_von,
 0 AS breakevenumsatz,
 0 AS systemrentabilitaet,
 0 AS verkaufsflaeche,
 0 AS betriebsflaeche,
 0 AS fleischsystem,
 CAST(NULL AS BIGNUMERIC) AS preiskategorie_food,
 CAST(NULL AS BIGNUMERIC) AS preiskategorie_nonfood,
 CAST(NULL AS BIGNUMERIC) AS sortkategorie_food,
 CAST(NULL AS BIGNUMERIC) AS sortkategorie_nonfood,
 CAST(NULL AS BIGNUMERIC) AS sondermarkt,
 0 AS ref_wup_id,
 - 1 AS wm_id,
 '' AS kassentyp,
 DATE '2709-12-31' AS dat_qbm_umstellung,
 CAST(NULL AS NUMERIC) AS lead_mwst,
 CAST(NULL AS BIGNUMERIC) AS region_id,
 1 AS kundenfaktor,
 CAST(NULL AS BIGNUMERIC) AS vz_wup_id,
 1 AS qbm_id,
 0 AS getraenkemarkt_fg,
 0 AS vs_id,
 CAST(NULL AS BIGNUMERIC) AS buchungskreis_id,
 '' AS verkaufsorganisation_id,
 CAST(NULL AS BIGNUMERIC) AS breitengrad,
 CAST(NULL AS BIGNUMERIC) AS laengengrad,
 CAST(NULL AS BIGNUMERIC) AS frische_manager_id
FROM kfl_production_dbp_view.v_mandant_2 AS M
UNION ALL
SELECT - 1 AS wup_id,
 - 111 AS nb_id,
 mandant_id,
 mandant_kbez AS land_id,
 DATE '1900-01-01' AS dat_von,
 2 AS wup_typ_id,
 '' AS wup_name_v,
 '--' AS wup_name_e,
 '--' AS wup_standort,
 '00000' AS wup_plz,
 '' AS wup_str,
 0 AS vf_id,
 - 1 AS vkl_id,
 CAST(NULL AS BIGNUMERIC) AS hl_id,
 DATE '9999-12-31' AS dat_bis,
 '' AS uebernahme_von,
 0 AS breakevenumsatz,
 0 AS systemrentabilitaet,
 0 AS verkaufsflaeche,
 0 AS betriebsflaeche,
 0 AS fleischsystem,
 CAST(NULL AS BIGNUMERIC) AS preiskategorie_food,
 CAST(NULL AS BIGNUMERIC) AS preiskategorie_nonfood,
 CAST(NULL AS BIGNUMERIC) AS sortkategorie_food,
 CAST(NULL AS BIGNUMERIC) AS sortkategorie_nonfood,
 CAST(NULL AS BIGNUMERIC) AS sondermarkt,
 0 AS ref_wup_id,
 - 1 AS wm_id,
 '' AS kassentyp,
 DATE '2709-12-31' AS dat_qbm_umstellung,
 CAST(NULL AS NUMERIC) AS lead_mwst,
 CAST(NULL AS BIGNUMERIC) AS region_id,
 1 AS kundenfaktor,
 CAST(NULL AS BIGNUMERIC) AS vz_wup_id,
 1 AS qbm_id,
 0 AS getraenkemarkt_fg,
 0 AS vs_id,
 CAST(NULL AS BIGNUMERIC) AS buchungskreis_id,
 '' AS verkaufsorganisation_id,
 CAST(NULL AS BIGNUMERIC) AS breitengrad,
 CAST(NULL AS BIGNUMERIC) AS laengengrad,
 CAST(NULL AS BIGNUMERIC) AS frische_manager_id
FROM kfl_production_dbp_view.v_mandant_2 AS M;