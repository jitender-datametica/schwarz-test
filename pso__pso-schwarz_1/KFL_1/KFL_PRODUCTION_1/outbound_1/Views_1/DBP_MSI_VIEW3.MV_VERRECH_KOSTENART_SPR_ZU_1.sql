-- 20230717 staeblern Umstellung auf Session Variable
 -- 02-08-2024, dknop, adding new kostenart_id

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_verrech_kostenart_spr_zu_1 (USERID STRING) AS ((((SELECT V01.mandant_id,
     V01.verrechfall_kostenart_id,
     V01.spr_id,
     V01.verrechfall_kostenart_bez
    FROM kfl_production_dbp_view.v_verrechfall_kostenart_spr_zu_1 AS V01
     INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_1(USERID) AS V02 ON V01.spr_id = V02.spr_id
      -- dbp_msi.akt_msi_user_spr_zu_1 v02

    UNION DISTINCT
    SELECT V01.mandant_id,
     'MDIES',
     V01.spr_id,
     'manuelle Berechnung Diesel-Anteil'
    FROM kfl_production_dbp_view.v_verrechfall_kostenart_spr_zu_1 AS V01
     INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_1(USERID) AS V02 ON V01.spr_id = V02.spr_id
      -- dbp_msi.akt_msi_user_spr_zu_1 v02
)
   UNION DISTINCT
   SELECT V01.mandant_id,
    'MSTRO',
    V01.spr_id,
    'manuelle Berechnung Strom-Anteil'
   FROM kfl_production_dbp_view.v_verrechfall_kostenart_spr_zu_1 AS V01
    INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_1(USERID) AS V02 ON V01.spr_id = V02.spr_id
     -- dbp_msi.akt_msi_user_spr_zu_1 v02
)
  UNION DISTINCT
  SELECT V01.mandant_id,
   'MGAS',
   V01.spr_id,
   'manuelle Berechnung Gas-Anteil'
  FROM kfl_production_dbp_view.v_verrechfall_kostenart_spr_zu_1 AS V01
   INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_1(USERID) AS V02 ON V01.spr_id = V02.spr_id
    -- dbp_msi.akt_msi_user_spr_zu_1 v02
)
 UNION DISTINCT
 SELECT V01.mandant_id,
  'MMAUT',
  V01.spr_id,
  'manuelle Berechnung Maut-Anteil'
 FROM kfl_production_dbp_view.v_verrechfall_kostenart_spr_zu_1 AS V01
  INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_1(USERID) AS V02 ON V01.spr_id = V02.spr_id
   -- dbp_msi.akt_msi_user_spr_zu_1 v02
)
UNION DISTINCT
SELECT V01.mandant_id,
 'MKUEH',
 V01.spr_id,
 'manuelle Berechnung Kühlung-Anteil'
FROM kfl_production_dbp_view.v_verrechfall_kostenart_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_user_spr_zu_1(USERID) AS V02 ON V01.spr_id = V02.spr_id
  -- dbp_msi.akt_msi_user_spr_zu_1 v02
;