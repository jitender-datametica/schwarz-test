create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_L_UNTERNMNS_BEREICH_1(
	MANDANT_ID,
	UNTERNEHMENS_BEREICH_ID
) as
   SELECT
   mandant_id, unternehmens_bereich_id
   FROM dbp_view.v_l_unternmns_bereich_1
;