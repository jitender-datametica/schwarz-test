-- 02.01.2023 twie: NSR3425817 mandant_sort_id hinzugefügt
 CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_mandant_2 (mandant_id
, mandant_bez, mandant_kbez, mandant_sort_id) AS SELECT mandant_id,
 mandant_bez,
 mandant_kbez,
 mandant_sort_id
FROM kfl_production_dbp_view.v_mandant_2;