CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_dim_source_1 (source_flag, `desc`) AS SELECT 0 AS source_flag,
 '3Soft' AS `desc`
UNION ALL
SELECT 1 AS source_flag,
 'Internal' AS `desc`;