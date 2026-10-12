CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wetterzustand_spr_zu_1 AS SELECT wetterzustand_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN wetterzustand_bez
   ELSE NULL
   END) AS wetterzustand_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN wetterzustand_bez
   ELSE NULL
   END) AS wetterzustand_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN wetterzustand_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wetterzustand_bez
    ELSE NULL
    END)) AS wetterzustand_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN wetterzustand_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wetterzustand_bez
    ELSE NULL
    END)) AS wetterzustand_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN wetterzustand_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wetterzustand_bez
    ELSE NULL
    END)) AS wetterzustand_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN wetterzustand_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wetterzustand_bez
    ELSE NULL
    END)) AS wetterzustand_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN wetterzustand_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wetterzustand_bez
    ELSE NULL
    END)) AS wetterzustand_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN wetterzustand_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wetterzustand_bez
    ELSE NULL
    END)) AS wetterzustand_bez_bg
FROM kfl_production_dbp_view.v_wetterzustand_spr_zu_1 AS V01
GROUP BY wetterzustand_id;