CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WUP_HIERARCHIE_1
(
mandant_id
,wup_id
,nb_id
,hausleiter_id
,vkl_id
,gf_gbl_vertrieb_id
,glv_land_id
,gl_vertrieb_id
,regionale_psb_id
,wbl_food_id
,wbl_frische_id
,wbl_noon_food_id
,wbl_kasse_id
,parkhaus_kz
,frische_manager_id
)
AS
   SELECT

   w.mandant_id, w.wup_id, w.nb_id, COALESCE(hausleiter_id,-1)      AS hausleiter_id, COALESCE(vkl_id,-1)             AS vkl_id, COALESCE(gf_gbl_vertrieb_id,-1) AS gf_gbl_vertrieb_id, COALESCE(glv_land_id,-1)        AS glv_land_id, COALESCE(gl_vertrieb_id,-1)     AS gl_vertrieb_id, COALESCE(regionale_psb_id,-1)   AS regionale_psb_id, COALESCE(wbl_food_id,-1)        AS wbl_food_id, COALESCE(wbl_frische_id,-1)     AS wbl_frische_id, COALESCE(wbl_nonfood_id,-1)     AS wbl_noon_food_id, COALESCE(wbl_kasse_id, -1)      AS wbl_kasse_id, COALESCE(frische_manager_id,-1) AS frische_manager_id, parkhaus_kz

   FROM (SELECT mandant_id,
   wup_id,
   nb_id,
   dat_eroeffnung
   FROM dbp_view.v_wup_1
   ) w
   LEFT JOIN dbp_msi_v_view.v_wup_denorm_1 wd
   ON wd.wup_id = w.wup_id
   AND wd.mandant_id = w.mandant_id
   ;