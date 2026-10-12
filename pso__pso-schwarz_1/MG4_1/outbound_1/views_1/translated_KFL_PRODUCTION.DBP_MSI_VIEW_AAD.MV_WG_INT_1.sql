-- 10.07.2023 snik: SPEC0202038 WG Lookup
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_wg_int_1 (arthiertyp_id, wg_id,
owg_id) AS SELECT DISTINCT arthiertyp_id,
 wg_id,
 owg_id
FROM kfl_production_dbp_view.v_wg_per_1 AS wg
WHERE arthiertyp_id = 2
 AND dat_bis = DATE '9999-12-31';