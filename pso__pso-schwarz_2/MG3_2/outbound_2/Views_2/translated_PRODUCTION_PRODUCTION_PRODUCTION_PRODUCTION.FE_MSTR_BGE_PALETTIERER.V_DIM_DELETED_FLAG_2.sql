CREATE OR REPLACE VIEW production_production_fe_mstr_bge_palettierer.v_dim_deleted_flag_2 (alerts_deleted_fg) AS 
select cast(alerts_deleted_fg as bool) from (
SELECT 0 AS alerts_deleted_fg
UNION ALL
SELECT 1 AS alerts_deleted_fg);