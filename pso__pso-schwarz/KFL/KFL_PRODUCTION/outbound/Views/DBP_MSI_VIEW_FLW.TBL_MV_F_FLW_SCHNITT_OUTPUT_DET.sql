CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_schnitt_output_det (mandant_id, in_art_id,
schnitt_id, sek_schl_typ_id, sek_schl_id, schnitt_pos_id, menge_schnitt, wrg_id, default_wrg, betrag_schnitt_output,
dat_kalk_ab_v02, dat_kalk_ab_v03) AS SELECT V01.mandant_id,
 V01.flw_art_id AS in_art_id,
 V01.schnitt_id,
 V01.sek_schl_typ_id,
 V01.sek_schl_id,
 V01.schnitt_pos_id,
 V01.menge_schnitt,
 V01.wrg_id,
 V100.default_wrg,
 V01.betrag_schnitt_output,
 V02.dat_kalk_ab AS dat_kalk_ab_v02,
 V03.dat_kalk_ab AS dat_kalk_ab_v03
FROM kfl_production_dbp_view.v_flw_schnitt_output_det AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_kalk_material AS V02 ON V01.mandant_id = V02.mandant_id AND V01.sek_schl_id =
   V02.materialwert_kalk_id
 LEFT JOIN kfl_production_dbp_view.v_flw_kalk_plan AS V03 ON V01.mandant_id = V03.mandant_id AND V01.sek_schl_id = V03.plan_kalk_id
   
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON V01.mandant_id = V100.mandant_id
WHERE V01.sek_schl_typ_id IN ('M', 'P');