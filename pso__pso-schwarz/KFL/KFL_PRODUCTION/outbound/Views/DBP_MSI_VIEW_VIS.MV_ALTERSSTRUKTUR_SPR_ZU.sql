CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_altersstruktur_spr_zu AS SELECT altersstruktur_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN altersstruktur_bez
   ELSE NULL
   END) AS altersstruktur_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN altersstruktur_bez
   ELSE NULL
   END) AS altersstruktur_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN altersstruktur_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN altersstruktur_bez
    ELSE NULL
    END)) AS altersstruktur_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN altersstruktur_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN altersstruktur_bez
    ELSE NULL
    END)) AS altersstruktur_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN altersstruktur_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN altersstruktur_bez
    ELSE NULL
    END)) AS altersstruktur_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN altersstruktur_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN altersstruktur_bez
    ELSE NULL
    END)) AS altersstruktur_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN altersstruktur_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN altersstruktur_bez
    ELSE NULL
    END)) AS altersstruktur_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN altersstruktur_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN altersstruktur_bez
    ELSE NULL
    END)) AS altersstruktur_bez_bg
FROM kfl_production_dbp_view.v_altersstruktur_spr_zu AS V01
GROUP BY altersstruktur_id;