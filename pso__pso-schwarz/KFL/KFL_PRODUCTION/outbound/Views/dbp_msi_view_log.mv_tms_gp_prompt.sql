CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_tms_gp_prompt (tms_gp_id, tms_gp_name_chg_fg, tms_gp_name) AS
SELECT t4.tms_gp_id,
  CASE
  WHEN t4.tms_gp_name1 = '' AND t4.tms_gp_name IS NOT NULL
  THEN 1
  ELSE 0
  END AS tms_gp_name_chg_fg,
  CASE
  WHEN CASE
    WHEN t4.tms_gp_name1 = '' AND t4.tms_gp_name IS NOT NULL
    THEN 1
    ELSE 0
    END = 1
  THEN t4.tms_gp_name
  ELSE t4.tms_gp_name1
  END AS tms_gp_name
FROM (SELECT T1.tms_gp_id,
   t2.tms_gp_name,
   T1.tms_gp_name AS tms_gp_name1
  FROM kfl_production_dbp_view.v_tms_gp AS T1
   LEFT JOIN (SELECT mandant_id,
     system_id,
     tms_gp_id,
     MAX(tms_gp_name) AS tms_gp_name
    FROM kfl_production_dbp_view.v_tms_gp
    WHERE tms_gp_name <> ''
    GROUP BY mandant_id,
     system_id,
     tms_gp_id) AS t2 ON T1.mandant_id = t2.mandant_id AND T1.system_id = t2.system_id AND T1.tms_gp_id = t2.tms_gp_id
  GROUP BY T1.tms_gp_id,
   t2.tms_gp_name,
   tms_gp_name1) AS t4;