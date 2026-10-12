CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_schnittlist_mat_kost_2 (mandant_id, schnittliste_id,
sek_schl_typ_id, sek_schl_id, in_art_id, input_material_typ_id, kosten_block_id, wrg_id, default_wrg, intern_var_kosten
, dat_kalk_ab_v02, dat_kalk_ab_v03) AS SELECT V01.mandant_id,
 V01.schnittliste_id,
 V01.sek_schl_typ_id,
 V01.sek_schl_id,
 V01.flw_art_id AS in_art_id,
 V01.input_material_typ_id,
 V01.kosten_block_id,
 V01.wrg_id,
 V100.default_wrg,
 V01.intern_var_kosten,
 V02.dat_kalk_ab AS dat_kalk_ab_v02,
 V03.dat_kalk_ab AS dat_kalk_ab_v03
FROM kfl_production_dbp_view.v_flw_schnittliste_mat_kosten_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_flw_kalk_material_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.sek_schl_id =
   V02.materialwert_kalk_id
 LEFT JOIN kfl_production_dbp_view.v_flw_kalk_plan_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.sek_schl_id = V03.plan_kalk_id
   
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V100 ON V01.mandant_id = V100.mandant_id
WHERE V01.sek_schl_typ_id IN ('M', 'P');