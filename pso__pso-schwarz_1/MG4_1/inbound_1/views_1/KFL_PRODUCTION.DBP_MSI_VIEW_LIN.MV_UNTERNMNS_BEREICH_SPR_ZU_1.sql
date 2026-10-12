create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_UNTERNMNS_BEREICH_SPR_ZU_1(
	MANDANT_ID,
	UNTERNEHMENS_BEREICH_ID,
	SPR_ID,
	UNTERNEHMENS_BEREICH_BEZ
) as
   SELECT
   mandant_id, unternehmens_bereich_id, spr_id, unternehmens_bereich_bez
   FROM dbp_view.v_unternmns_bereich_spr_zu_1
   WHERE spr_id = 22
;