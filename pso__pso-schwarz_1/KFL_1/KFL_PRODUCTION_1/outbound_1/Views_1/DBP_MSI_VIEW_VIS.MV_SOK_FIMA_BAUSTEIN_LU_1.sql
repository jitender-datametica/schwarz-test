CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_fima_baustein_lu_1 (mandant_id, sok_fima_baustein_id,
sok_abteilung_id, sok_fima_baustein_bez_de, sok_fima_baustein_bez, sok_fima_baustein_bez_cz, sok_fima_baustein_bez_sk,
sok_fima_baustein_bez_hr, sok_fima_baustein_bez_pl, sok_fima_baustein_bez_ro, sok_fima_baustein_bez_bg) AS SELECT FIMA.mandant_id
 ,
 FIMA.sok_fima_baustein_id,
 FIMA.sok_abteilung_id,
 MAX(CASE
   WHEN FIMAS.spr_id = 22
   THEN FIMAS.sok_fima_baustein_bez
   ELSE TRIM(SUBSTR(CAST(FIMAS.sok_fima_baustein_id AS STRING), 1, 39))
   END) AS sok_fima_baustein_bez_de,
 MAX(CASE
   WHEN FIMAS.spr_id = 22
   THEN FIMAS.sok_fima_baustein_bez
   ELSE TRIM(SUBSTR(CAST(FIMAS.sok_fima_baustein_id AS STRING), 1, 39))
   END) AS sok_fima_baustein_bez,
 COALESCE(MAX(CASE
    WHEN FIMAS.spr_id = 124
    THEN FIMAS.sok_fima_baustein_bez
    ELSE NULL
    END), MAX(CASE
    WHEN FIMAS.spr_id = 22
    THEN FIMAS.sok_fima_baustein_bez
    ELSE TRIM(SUBSTR(CAST(FIMAS.sok_fima_baustein_id AS STRING), 1, 39))
    END)) AS sok_fima_baustein_bez_cz,
 COALESCE(MAX(CASE
    WHEN FIMAS.spr_id = 108
    THEN FIMAS.sok_fima_baustein_bez
    ELSE NULL
    END), MAX(CASE
    WHEN FIMAS.spr_id = 22
    THEN FIMAS.sok_fima_baustein_bez
    ELSE TRIM(SUBSTR(CAST(FIMAS.sok_fima_baustein_id AS STRING), 1, 39))
    END)) AS sok_fima_baustein_bez_sk,
 COALESCE(MAX(CASE
    WHEN FIMAS.spr_id = 65
    THEN FIMAS.sok_fima_baustein_bez
    ELSE NULL
    END), MAX(CASE
    WHEN FIMAS.spr_id = 22
    THEN FIMAS.sok_fima_baustein_bez
    ELSE TRIM(SUBSTR(CAST(FIMAS.sok_fima_baustein_id AS STRING), 1, 39))
    END)) AS sok_fima_baustein_bez_hr,
 COALESCE(MAX(CASE
    WHEN FIMAS.spr_id = 90
    THEN FIMAS.sok_fima_baustein_bez
    ELSE NULL
    END), MAX(CASE
    WHEN FIMAS.spr_id = 22
    THEN FIMAS.sok_fima_baustein_bez
    ELSE TRIM(SUBSTR(CAST(FIMAS.sok_fima_baustein_id AS STRING), 1, 39))
    END)) AS sok_fima_baustein_bez_pl,
 COALESCE(MAX(CASE
    WHEN FIMAS.spr_id = 95
    THEN FIMAS.sok_fima_baustein_bez
    ELSE NULL
    END), MAX(CASE
    WHEN FIMAS.spr_id = 22
    THEN FIMAS.sok_fima_baustein_bez
    ELSE TRIM(SUBSTR(CAST(FIMAS.sok_fima_baustein_id AS STRING), 1, 39))
    END)) AS sok_fima_baustein_bez_ro,
 COALESCE(MAX(CASE
    WHEN FIMAS.spr_id = 18
    THEN FIMAS.sok_fima_baustein_bez
    ELSE NULL
    END), MAX(CASE
    WHEN FIMAS.spr_id = 22
    THEN FIMAS.sok_fima_baustein_bez
    ELSE TRIM(SUBSTR(CAST(FIMAS.sok_fima_baustein_id AS STRING), 1, 39))
    END)) AS sok_fima_baustein_bez_bg
FROM kfl_production_dbp_view.v_l_sok_fima_baustein_1 AS FIMA
 INNER JOIN kfl_production_dbp_view.v_sok_fima_baustein_spr_zu_1 AS FIMAS ON FIMA.mandant_id = FIMAS.mandant_id AND FIMA.sok_fima_baustein_id
    = FIMAS.sok_fima_baustein_id
GROUP BY FIMA.mandant_id,
 FIMA.sok_fima_baustein_id,
 FIMA.sok_abteilung_id;