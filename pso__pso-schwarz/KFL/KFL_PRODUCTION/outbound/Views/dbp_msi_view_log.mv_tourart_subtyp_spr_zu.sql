CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_tourart_subtyp_spr_zu (tourart_subtyp_id, tourart_subtyp_bez,
tourart_subtyp_bez_de, tourart_subtyp_bez_cz, tourart_subtyp_bez_sk, tourart_subtyp_bez_hr, tourart_subtyp_bez_pl,
tourart_subtyp_bez_ro, tourart_subtyp_bez_b) AS SELECT tourart_subtyp_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN tourart_subtyp_bez
   ELSE NULL
   END) AS tourart_subtyp_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN tourart_subtyp_bez
   ELSE NULL
   END) AS tourart_subtyp_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN tourart_subtyp_bez
   ELSE NULL
   END) AS tourart_subtyp_bez_cz,
 MAX(CASE
   WHEN spr_id = 108
   THEN tourart_subtyp_bez
   ELSE NULL
   END) AS tourart_subtyp_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN tourart_subtyp_bez
   ELSE NULL
   END) AS tourart_subtyp_bez_hr,
 MAX(CASE
   WHEN spr_id = 90
   THEN tourart_subtyp_bez
   ELSE NULL
   END) AS tourart_subtyp_bez_pl,
 MAX(CASE
   WHEN spr_id = 95
   THEN tourart_subtyp_bez
   ELSE NULL
   END) AS tourart_subtyp_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN tourart_subtyp_bez
   ELSE NULL
   END) AS tourart_subtyp_bez_b
FROM kfl_production_dbp_view.v_tourart_subtyp_spr_zu AS V01
GROUP BY tourart_subtyp_id;