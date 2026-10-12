CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_nachlieferung_user (user_id) AS SELECT DISTINCT *
FROM (SELECT 'knic0207' AS user_id
   FROM kfl_production_dbp_view.v_mandant
   UNION ALL
   SELECT 'rbra1511' AS user_id
   FROM kfl_production_dbp_view.v_mandant
   UNION ALL
   SELECT 'rkot0904' AS user_id
   FROM kfl_production_dbp_view.v_mandant
   UNION ALL
   SELECT 'rdre0109' AS user_id
   FROM kfl_production_dbp_view.v_mandant
   UNION ALL
   SELECT 'rher0703' AS user_id
   FROM kfl_production_dbp_view.v_mandant
   UNION ALL
   SELECT 'ssve1704' AS user_id
   FROM kfl_production_dbp_view.v_mandant
   UNION ALL
   SELECT 'sbue1308' AS user_id
   FROM kfl_production_dbp_view.v_mandant
   UNION ALL
   SELECT 'sbuy2107' AS user_id
   FROM kfl_production_dbp_view.v_mandant
   UNION ALL
   SELECT 'ssch1303' AS user_id
   FROM kfl_production_dbp_view.v_mandant
   UNION ALL
   SELECT 'hufeld' AS user_id
   FROM kfl_production_dbp_view.v_mandant
   UNION ALL
   SELECT 'be_bakos' AS user_id
   FROM kfl_production_dbp_view.v_mandant
   UNION ALL
   SELECT 'prescherad' AS user_id
   FROM kfl_production_dbp_view.v_mandant) AS t11;