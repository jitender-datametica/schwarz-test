CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_ts_werbebereich_werbeteam_zu_1 (mandant_id, mandant_bez,
wg_id, wg_bez, werbeteam, werbeteambereich, werbebereich) AS SELECT V01.mandant_id,
 'DE' AS mandant_bez,
 V01.wg_id,
 V03.wg_bez,
  CASE
  WHEN V02.werbeteam_cd IS NULL
  THEN 'nicht vorhanden'
  ELSE V02.werbeteam_cd
  END AS werbeteam,
  CASE
  WHEN V02.werbeteam_bez IS NULL
  THEN 'nicht vorhanden'
  ELSE V02.werbeteam_bez
  END AS werbeteambereich,
  CASE
  WHEN V02.werbebereich_cd IS NULL
  THEN 'nicht vorhanden'
  ELSE V02.werbebereich_cd
  END AS werbebereich
FROM kfl_production_dbp_view.v_wg_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wg_spr_zu_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.wg_id = V03.wg_id AND
     V03.spr_id = 22 AND V01.mandant_id = 1 AND V01.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_msi_data.ts_werbebereich_werbeteam_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wg_id
    = V02.wg_id;