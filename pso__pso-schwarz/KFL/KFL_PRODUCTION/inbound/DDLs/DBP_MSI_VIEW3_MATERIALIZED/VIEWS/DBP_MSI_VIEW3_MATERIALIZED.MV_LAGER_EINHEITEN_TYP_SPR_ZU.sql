create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LAGER_EINHEITEN_TYP_SPR_ZU(
	MANDANT_ID,
	LAGERNUMMER_ID,
	WUP_ID,
	NB_ID,
	LAGER_EINHEITEN_TYP,
	SPR_ID,
	LAGER_EINHEITEN_TYP_BEZ
) as 
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
   dbp_view.v_lager_einheiten_typ_spr_zu v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;