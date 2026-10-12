-- 07.06.2023 twie: SPEC0200542 Lookup Mandant_1
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_mandant_1 (mandant_id,
mandant_bez, mandant_kbez, mandant_sort_id) AS SELECT mandant_id,
 mandant_bez,
 mandant_kbez,
 mandant_sort_id
FROM kfl_production_dbp_view.v_mandant_1;