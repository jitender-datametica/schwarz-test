CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_kalk_preise (mandant_id, schnittliste_id,
sek_schl_typ_id, sek_schl_id, in_art_id, input_material_typ_id, menge, gesamt_wert, menge_dme, dme_einh_id, wrg_id,
preis_kg, default_wrg, dat_kalk_ab_v02, dat_kalk_ab_v03) AS SELECT V01.mandant_id,
 V01.schnittliste_id,
 V01.sek_schl_typ_id,
 V01.sek_schl_id,
 V01.flw_art_id AS in_art_id,
 V01.input_material_typ_id,
 V01.menge,
 V01.gesamt_wert,
 V01.menge_dme,
 V01.dme_einh_id,
 V01.wrg_id,
 V01.preis_kg,
 V100.default_wrg,
 V02.dat_kalk_ab AS dat_kalk_ab_v02,
 V03.dat_kalk_ab AS dat_kalk_ab_v03
FROM kfl_production_dbp_view.v_flw_kalk_preise AS V01
 LEFT JOIN kfl_production_dbp_view.v_flw_kalk_material AS V02 ON V01.mandant_id = V02.mandant_id AND V01.sek_schl_id =
   V02.materialwert_kalk_id
 LEFT JOIN kfl_production_dbp_view.v_flw_kalk_plan AS V03 ON V01.mandant_id = V03.mandant_id AND V01.sek_schl_id = V03.plan_kalk_id
   
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON V01.mandant_id = V100.mandant_id
WHERE V01.sek_schl_typ_id IN ('M', 'P');