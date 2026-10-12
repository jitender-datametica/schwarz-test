create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_MA_GESCHLECHT_SPR_ZU_2(
	MANDANT_ID,
	GESCHLECHT_ID,
	SPR_ID,
	GESCHLECHT_BEZ,
	ANREDE_BEZ
) as
   SELECT
   v01.mandant_id, v01.geschlecht_id, v01.spr_id, v01.geschlecht_bez, v01.anrede_bez

   FROM dbp_view.v_ma_geschlecht_spr_zu_2 v01

   WHERE spr_id = 22;