create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_GEKU_KUNDENBAROMETER(
	GEKU_TICKET_ID_KUNDENBAROMETER,
	DAT,
	WUP_ID,
	NB_ID,
	MANDANT_ID
) as
-- 31.08.2017 twie: SPEC0025359 mandant_id_wup als mandant_id, es gibt nur noch ein Landattr. in KMR

   SELECT
   geku_ticket_id_kundenbarometer
   , dat
   , wup_id
   , nb_id
   , mandant_id_wup AS mandant_id
   FROM dbp_view.v_geku_kundenbarometer;