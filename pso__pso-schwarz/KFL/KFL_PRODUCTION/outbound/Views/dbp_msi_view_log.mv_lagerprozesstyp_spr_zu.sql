CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lagerprozesstyp_spr_zu AS SELECT lagerprozesstyp_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN lagerprozesstyp_bez
   ELSE NULL
   END) AS lagerprozesstyp_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN lagerprozesstyp_bez
   ELSE NULL
   END) AS lagerprozesstyp_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN lagerprozesstyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerprozesstyp_bez
    ELSE NULL
    END)) AS lagerprozesstyp_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN lagerprozesstyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerprozesstyp_bez
    ELSE NULL
    END)) AS lagerprozesstyp_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN lagerprozesstyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerprozesstyp_bez
    ELSE NULL
    END)) AS lagerprozesstyp_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN lagerprozesstyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerprozesstyp_bez
    ELSE NULL
    END)) AS lagerprozesstyp_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN lagerprozesstyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerprozesstyp_bez
    ELSE NULL
    END)) AS lagerprozesstyp_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN lagerprozesstyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerprozesstyp_bez
    ELSE NULL
    END)) AS lagerprozesstyp_bez_bg
FROM kfl_production_dbp_view.v_lagerprozesstyp_spr_zu AS V01
GROUP BY lagerprozesstyp_id;