CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_wg_lu (mandant_id, sok_wg_id, sok_platzierungswg_id,
sort_id, arthiertyp_id, sok_wg_bez_de, sok_wg_bez, sok_wg_bez_cz, sok_wg_bez_sk, sok_wg_bez_hr, sok_wg_bez_pl,
sok_wg_bez_ro, sok_wg_bez_bg) AS SELECT WG.mandant_id,
 WG.wg_id AS sok_wg_id,
 WG.platzierungswg_id AS sok_platzierungswg_id,
   WG.owg_id * 10000 + CAST(WG.wg_id AS BIGNUMERIC) AS sort_id,
 WGS.arthiertyp_id,
 MAX(CASE
   WHEN WGS.spr_id = 22
   THEN WGS.wg_bez
   ELSE TRIM(SUBSTR(CAST(WGS.wg_id AS STRING), 1, 39))
   END) AS sok_wg_bez_de,
 MAX(CASE
   WHEN WGS.spr_id = 22
   THEN WGS.wg_bez
   ELSE TRIM(SUBSTR(CAST(WGS.wg_id AS STRING), 1, 39))
   END) AS sok_wg_bez,
 COALESCE(MAX(CASE
    WHEN WGS.spr_id = 124
    THEN WGS.wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN WGS.spr_id = 22
    THEN WGS.wg_bez
    ELSE TRIM(SUBSTR(CAST(WGS.wg_id AS STRING), 1, 39))
    END)) AS sok_wg_bez_cz,
 COALESCE(MAX(CASE
    WHEN WGS.spr_id = 108
    THEN WGS.wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN WGS.spr_id = 22
    THEN WGS.wg_bez
    ELSE TRIM(SUBSTR(CAST(WGS.wg_id AS STRING), 1, 39))
    END)) AS sok_wg_bez_sk,
 COALESCE(MAX(CASE
    WHEN WGS.spr_id = 65
    THEN WGS.wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN WGS.spr_id = 22
    THEN WGS.wg_bez
    ELSE TRIM(SUBSTR(CAST(WGS.wg_id AS STRING), 1, 39))
    END)) AS sok_wg_bez_hr,
 COALESCE(MAX(CASE
    WHEN WGS.spr_id = 90
    THEN WGS.wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN WGS.spr_id = 22
    THEN WGS.wg_bez
    ELSE TRIM(SUBSTR(CAST(WGS.wg_id AS STRING), 1, 39))
    END)) AS sok_wg_bez_pl,
 COALESCE(MAX(CASE
    WHEN WGS.spr_id = 95
    THEN WGS.wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN WGS.spr_id = 22
    THEN WGS.wg_bez
    ELSE TRIM(SUBSTR(CAST(WGS.wg_id AS STRING), 1, 39))
    END)) AS sok_wg_bez_ro,
 COALESCE(MAX(CASE
    WHEN WGS.spr_id = 18
    THEN WGS.wg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN WGS.spr_id = 22
    THEN WGS.wg_bez
    ELSE TRIM(SUBSTR(CAST(WGS.wg_id AS STRING), 1, 39))
    END)) AS sok_wg_bez_bg
FROM kfl_production_dbp_view.v_wg_per AS WG
 INNER JOIN kfl_production_dbp_view.v_wg_spr_zu AS WGS ON WG.mandant_id = WGS.mandant_id AND WG.wg_id = WGS.wg_id
WHERE WG.arthiertyp_id = 2
 AND WG.dat_bis = DATE '9999-12-31'
GROUP BY WG.mandant_id,
 sok_wg_id,
 sok_platzierungswg_id,
 sort_id,
 WGS.arthiertyp_id;