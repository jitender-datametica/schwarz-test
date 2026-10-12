CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_teku_kum_spr_zu AS SELECT CAST(CASE
   WHEN teku_attribut_id = 351
   THEN 1
   WHEN teku_attribut_id = 396
   THEN 2
   ELSE NULL
   END AS BIGNUMERIC) AS kum_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN teku_attribut_bez
   ELSE NULL
   END) AS kum_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN teku_attribut_bez
   ELSE NULL
   END) AS kum_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN teku_attribut_bez
   ELSE NULL
   END) AS kum_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN teku_attribut_bez
   ELSE NULL
   END) AS kum_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN teku_attribut_bez
   ELSE NULL
   END) AS kum_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN teku_attribut_bez
   ELSE NULL
   END) AS kum_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN teku_attribut_bez
   ELSE NULL
   END) AS kum_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN teku_attribut_bez
   ELSE NULL
   END) AS kum_bez_bg
FROM kfl_production_dbp_msi_v_view.v_l_teku_attribut
WHERE teku_attribut_id IN (351, 396)
GROUP BY kum_id;