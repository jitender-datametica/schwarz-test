CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_transport_gv_spr_zu_1 (transport_gv_id, transport_gv_bez,
transport_gv_bez_de, transport_gv_bez_cz, transport_gv_bez_sk, transport_gv_bez_hr, transport_gv_bez_pl,
transport_gv_bez_ro, transport_gv_bez_bg, ewm_fg) AS SELECT CAST(transport_gv_id AS STRING) AS transport_gv_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN transport_gv_bez
   ELSE NULL
   END) AS transport_gv_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN transport_gv_bez
   ELSE NULL
   END) AS transport_gv_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN transport_gv_bez
   ELSE NULL
   END) AS transport_gv_bezz_cz,
 MAX(CASE
   WHEN spr_id = 108
   THEN transport_gv_bez
   ELSE NULL
   END) AS transport_gv_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN transport_gv_bez
   ELSE NULL
   END) AS transport_gv_bez_hr,
 MAX(CASE
   WHEN spr_id = 90
   THEN transport_gv_bez
   ELSE NULL
   END) AS transport_gv_bez_pl,
 MAX(CASE
   WHEN spr_id = 95
   THEN transport_gv_bez
   ELSE NULL
   END) AS transport_gv_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN transport_gv_bez
   ELSE NULL
   END) AS transport_gv_bez_bg,
 0 AS ewm_fg
FROM kfl_production_dbp_view.v_transport_gv_spr_zu_1 AS V01
GROUP BY V01.transport_gv_id
UNION DISTINCT
SELECT CAST(ewm_gv_id AS STRING) AS ewm_gv_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ewm_gv_bez
   ELSE NULL
   END) AS ewm_gv_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN ewm_gv_bez
   ELSE NULL
   END) AS ewm_gv_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN ewm_gv_bez
   ELSE NULL
   END) AS ewm_gv_bez_cz,
 MAX(CASE
   WHEN spr_id = 108
   THEN ewm_gv_bez
   ELSE NULL
   END) AS ewm_gv_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN ewm_gv_bez
   ELSE NULL
   END) AS ewm_gv_bez_hr,
 MAX(CASE
   WHEN spr_id = 90
   THEN ewm_gv_bez
   ELSE NULL
   END) AS ewm_gv_bez_pl,
 MAX(CASE
   WHEN spr_id = 95
   THEN ewm_gv_bez
   ELSE NULL
   END) AS ewm_gv_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN ewm_gv_bez
   ELSE NULL
   END) AS ewm_gv_bez_bg,
 1 AS ewm_fg
FROM kfl_production_dbp_view.v_ewm_geschaeftsvorfall_spr_zu_1 AS V01
GROUP BY V01.ewm_gv_id;