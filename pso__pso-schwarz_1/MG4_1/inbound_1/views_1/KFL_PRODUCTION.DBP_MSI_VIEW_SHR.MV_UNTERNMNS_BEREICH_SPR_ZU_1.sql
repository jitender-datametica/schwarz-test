create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_UNTERNMNS_BEREICH_SPR_ZU_1(
	MANDANT_ID,
	UNTERNEHMENS_BEREICH_ID,
	SPR_ID,
	UNTERNEHMENS_BEREICH_BEZ
) as
   SELECT
   v01.mandant_id, v01.unternehmens_bereich_id, v01.spr_id, v01.unternehmens_bereich_bez

   FROM dbp_view.v_unternmns_bereich_spr_zu_1 v01
   WHERE spr_id = 22
;