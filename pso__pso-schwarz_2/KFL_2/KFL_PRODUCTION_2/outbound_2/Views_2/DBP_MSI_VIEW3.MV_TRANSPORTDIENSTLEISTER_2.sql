CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_transportdienstleister_2 (mandant_id, belos_adresse_spedition_id,
tdl_name_belos, tdl_name_wanko, belos_fg, wanko_fg, adress_name, land_id, adress_name_zusatz, strasse, be_entlade_stelle
, plz, ansprechpartner, ort) AS SELECT mandant_id,
 belos_adresse_spedition_id,
 MAX(CASE
   WHEN tdl_src = 'BELOS'
   THEN adress_name
   ELSE NULL
   END) AS tdl_name_belos,
 MAX(CASE
   WHEN tdl_src = 'WANKO'
   THEN adress_name
   ELSE NULL
   END) AS tdl_name_wanko,
 MAX(CASE
   WHEN tdl_src = 'BELOS'
   THEN 1
   ELSE 0
   END) AS belos_fg,
 MAX(CASE
   WHEN tdl_src = 'WANKO'
   THEN 1
   ELSE 0
   END) AS wanko_fg,
 COALESCE(MAX(CASE
    WHEN tdl_src = 'WANKO'
    THEN adress_name
    ELSE NULL
    END), MAX(CASE
    WHEN tdl_src = 'BELOS'
    THEN adress_name
    ELSE NULL
    END)) AS adress_name,
 MAX(land_id) AS land_id,
 MAX(adress_name_zusatz) AS adress_name_zusatz,
 MAX(strasse) AS strasse,
 MAX(be_entlade_stelle) AS be_entlade_stelle,
 MAX(plz) AS plz,
 MAX(ansprechpartner) AS ansprechpartner,
 MAX(ort) AS ort
FROM ((SELECT 'BELOS' AS tdl_src,
     mandant_id,
     belos_adresse_id AS belos_adresse_spedition_id,
     land_id,
     adress_name,
     adress_name_zusatz,
     strasse,
     be_entlade_stelle,
     plz,
     ansprechpartner,
     ort
    FROM kfl_production_dbp_view.v_belos_adresse_2
    WHERE spedition_fg = 1
    UNION DISTINCT
    SELECT 'BELOS' AS tdl_src,
     mandant_id,
     '' AS belos_adresse_spedition_id,
     '' AS land_id,
     'nicht definiert / not defined' AS adress_name,
     '' AS adress_name_zusatz,
     '' AS strasse,
     '' AS be_entlade_stelle,
     '' AS plz,
     '' AS ansprechpartner,
     '' AS ort
    FROM kfl_production_dbp_view.v_mandant_2)
   UNION DISTINCT
   SELECT 'WANKO' AS tdl_src,
    GP.mandant_id,
    GP.tms_gp_id AS belos_adresse_id,
    GP.tms_land_cd AS land_id,
    GP.tms_gp_name AS adress_name,
    GP.tms_gp_altnv_name AS adress_name_zusatz,
    GP.tms_gp_strasse AS strasse,
    '' AS be_entlade_stelle,
    GP.tms_gp_plz AS plz,
    '' AS ansprechpartner,
    GP.tms_gp_ort_name AS ort
   FROM kfl_production_dbp_data.tms_gp_2 AS GP_2
    INNER JOIN kfl_production_dbp_view.v_l_system_2 AS S ON GP.system_id = S.system_id
   WHERE GP.tms_gp_typ_cd = 'S'
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(GP.mandant_id AS STRING), GP.tms_gp_id ORDER BY CASE
          WHEN LEFT(S.kl_system_bez, 3) <> 'FLW'
          THEN 0
          ELSE 1
          END IS NULL, CASE
          WHEN LEFT(S.kl_system_bez, 3) <> 'FLW'
          THEN 0
          ELSE 1
          END)) = 1) AS v00
GROUP BY mandant_id,
 belos_adresse_spedition_id;