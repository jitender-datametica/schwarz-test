CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LAGER_EINHEITEN_TYP_SPR_ZU_2 (
   mandant_id,
   lagernummer_id,
   wup_id,
   nb_id,
   lager_einheiten_typ,
   spr_id,
   lager_einheiten_typ_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.lagernummer_id,
   v01.wup_id,
   v01.nb_id,
   v01.lager_einheiten_typ,
   v01.spr_id,
   v01.lager_einheiten_typ_bez
FROM
   dbp_view.v_lager_einheiten_typ_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;