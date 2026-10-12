CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artkz_loesch_spr_zu AS SELECT mandant_id,
 loesch_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN loesch_bez
    ELSE NULL
    END), 'N/A') AS loesch_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN loesch_bez
    ELSE NULL
    END), 'N/A') AS loesch_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN loesch_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN loesch_bez
     ELSE NULL
     END), 'N/A')) AS loesch_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN loesch_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN loesch_bez
     ELSE NULL
     END), 'N/A')) AS loesch_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN loesch_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN loesch_bez
     ELSE NULL
     END), 'N/A')) AS loesch_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN loesch_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN loesch_bez
     ELSE NULL
     END), 'N/A')) AS loesch_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN loesch_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN loesch_bez
     ELSE NULL
     END), 'N/A')) AS loesch_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN loesch_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN loesch_bez
     ELSE NULL
     END), 'N/A')) AS loesch_bez_bg
FROM (SELECT DISTINCT V02.mandant_id,
   V01.loesch_id,
    CASE
    WHEN V01.loesch_bez = 'system generated'
    THEN 'ZEK Status aktiv'
    ELSE V01.loesch_bez
    END AS loesch_bez,
   V01.spr_id
  FROM kfl_production_dbp_view.v_artkz_loesch AS V01
   INNER JOIN kfl_production_dbp_view.v_mandant AS V02 ON V01.loesch_id NOT IN ('ZB', 'ZL', 'ZR', 'ZV', '01', '01', '02'
     )
  WHERE V01.mandant_id <> 1) AS v01
WHERE mandant_id <> 1
GROUP BY mandant_id,
 loesch_id;