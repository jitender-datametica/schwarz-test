CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_verrech_kostenart_spr_zu_1(USERID STRING) AS (SELECT V01.mandant_id,
  V01.verrechfall_kostenart_id,
  V01.spr_id,
  V01.verrechfall_kostenart_bez
 FROM kfl_production_dbp_view.v_verrechfall_kostenart_spr_zu_1 AS V01
  INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu_1(USERID) AS V02 ON V01.spr_id = V02.spr_id
 UNION DISTINCT
 (SELECT V010.mandant_id,
   'MDIES',
   V010.spr_id,
   'manuelle Berechnung Diesel-Anteil'
  FROM kfl_production_dbp_view.v_verrechfall_kostenart_spr_zu_1 AS V010
   INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu_1(USERID) AS V020 ON V010.spr_id = V020.spr_id
  UNION DISTINCT
  SELECT V011.mandant_id,
   'MSTRO',
   V011.spr_id,
   'manuelle Berechnung Strom-Anteil'
  FROM kfl_production_dbp_view.v_verrechfall_kostenart_spr_zu_1 AS V011
   INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu_1(USERID) AS V021 ON V011.spr_id = V021.spr_id))
UNION DISTINCT
(SELECT V012.mandant_id,
  'MGAS',
  V012.spr_id,
  'manuelle Berechnung Gas-Anteil'
 FROM kfl_production_dbp_view.v_verrechfall_kostenart_spr_zu_1 AS V012
  INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu_1(USERID) AS V022 ON V012.spr_id = V022.spr_id
 UNION DISTINCT
 (SELECT V013.mandant_id,
   'MMAUT',
   V013.spr_id,
   'manuelle Berechnung Maut-Anteil'
  FROM kfl_production_dbp_view.v_verrechfall_kostenart_spr_zu_1 AS V013
   INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu_1(USERID) AS V023 ON V013.spr_id = V023.spr_id
  UNION DISTINCT
  SELECT V014.mandant_id,
   'MKUEH',
   V014.spr_id,
   'manuelle Berechnung Kühlung-Anteil'
  FROM kfl_production_dbp_view.v_verrechfall_kostenart_spr_zu_1 AS V014
   INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_user_spr_zu_1(USERID) AS V024 ON V014.spr_id = V024.spr_id));