-- 22.06.2022 twie: SPEC0145413 Sprachtabelle Warengruppe
 -- standard=deutsch

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_wg_spr_zu (wg_id, arthiertyp_id, mandant_id,
wg_bez, wg_bez_cz, wg_bez_pl, wg_bez_sk, wg_bez_hr, wg_bez_ro, wg_bez_bg) AS SELECT wg_id,
 arthiertyp_id,
 mandant_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN wg_bez
   ELSE NULL
   END) AS wg_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN wg_bez
   ELSE NULL
   END) AS wg_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN wg_bez
   ELSE NULL
   END) AS wg_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN wg_bez
   ELSE NULL
   END) AS wg_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN wg_bez
   ELSE NULL
   END) AS wg_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN wg_bez
   ELSE NULL
   END) AS wg_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN wg_bez
   ELSE NULL
   END) AS wg_bez_bg
FROM kfl_production_dbp_view.v_wg_spr_zu AS V01
WHERE arthiertyp_id = 2
 AND wg_id >= -3
GROUP BY wg_id,
 arthiertyp_id,
 mandant_id;