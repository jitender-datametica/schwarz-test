CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_ek_hierarchie_1 (mandant_id, zek_id, zek_name, wbl_id,
wbl_name, gf_id, gf_name) AS SELECT V01.mandant_id,
 V01.zek_id,
 V01.zek_name,
 V01.wbl_id,
 V02.wbl_name,
 V02.gf_id,
 V03.gf_name
FROM kfl_production_dbp_view.v_zek_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wbl_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wbl_id = V02.wbl_id
 INNER JOIN kfl_production_dbp_view.v_gf_1 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.gf_id = V03.gf_id;