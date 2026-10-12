CREATE OR REPLACE VIEW produktion_fe_mstr_bge_palettierer.v_dim_deleted_flag_1 (alerts_deleted_fg) AS SELECT
 cast(alerts_deleted_fg as bool)
FROM (SELECT 0 AS alerts_deleted_fg
   UNION ALL
   SELECT 1 AS alerts_deleted_fg);