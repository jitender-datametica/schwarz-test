CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_wup_hierarchie_2 (mandant_id, wup_id, nb_id, hausleiter_id,
vkl_id, gf_gbl_vertrieb_id, glv_land_id, gl_vertrieb_id, regionale_psb_id, wbl_food_id, wbl_frische_id, wbl_noon_food_id
, wbl_kasse_id, parkhaus_kz, frische_manager_id) AS SELECT w.mandant_id,
 w.wup_id,
 w.nb_id,
 COALESCE(WD.hausleiter_id, - 1) AS hausleiter_id,
 COALESCE(WD.vkl_id, - 1) AS vkl_id,
 COALESCE(WD.gf_gbl_vertrieb_id, - 1) AS gf_gbl_vertrieb_id,
 COALESCE(WD.glv_land_id, - 1) AS glv_land_id,
 COALESCE(WD.gl_vertrieb_id, - 1) AS gl_vertrieb_id,
 COALESCE(WD.regionale_psb_id, - 1) AS regionale_psb_id,
 COALESCE(WD.wbl_food_id, - 1) AS wbl_food_id,
 COALESCE(WD.wbl_frische_id, - 1) AS wbl_frische_id,
 COALESCE(WD.wbl_nonfood_id, - 1) AS wbl_noon_food_id,
 COALESCE(WD.wbl_kasse_id, - 1) AS wbl_kasse_id,
 COALESCE(WD.frische_manager_id, - 1) AS frische_manager_id0,
 WD.parkhaus_kz AS frische_manager_id
FROM (SELECT mandant_id,
   wup_id,
   nb_id,
   dat_eroeffnung
  FROM kfl_production_dbp_view.v_wup_2) AS w
 LEFT JOIN kfl_production_dbp_msi_v_view.v_wup_denorm_2 AS WD ON w.wup_id = WD.wup_id AND w.mandant_id = WD.mandant_id;