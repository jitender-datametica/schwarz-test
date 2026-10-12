create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_FLW_KALK_VARIANTE_SPR_ZU_1(
	MANDANT_ID,
	KALK_VARIANTE_ID,
	SPR_ID,
	KALK_VARIANTE_BEZ,
	MANDANT_KBEZ
) as 
   SELECT
    v01.mandant_id, v01.kalk_variante_id, v01.spr_id, v01.kalk_variante_bez, v01.mandant_kbez

   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_FLW_KALK_VARIANTE_SPR_ZU_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id;