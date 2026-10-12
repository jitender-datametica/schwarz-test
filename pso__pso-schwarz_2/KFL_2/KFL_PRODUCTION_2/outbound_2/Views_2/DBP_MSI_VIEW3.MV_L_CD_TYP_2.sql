CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_cd_typ_2 (mandant_id, cd_typ_id) AS SELECT mandant_id,
 cd_typ_id
FROM kfl_production_dbp_view.v_l_cd_typ_2
UNION DISTINCT
SELECT mandant_id,
 '-1' AS cd_typ_id
FROM kfl_production_dbp_view.v_mandant_2;