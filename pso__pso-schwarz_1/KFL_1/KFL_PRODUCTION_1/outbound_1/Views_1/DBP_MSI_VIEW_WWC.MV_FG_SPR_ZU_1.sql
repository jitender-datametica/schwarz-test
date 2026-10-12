CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_fg_spr_zu_1 AS SELECT 1 AS fg_id,
 'X' AS fg_kbez
UNION DISTINCT
SELECT 0 AS fg_id,
 ' ' AS fg_kbez;