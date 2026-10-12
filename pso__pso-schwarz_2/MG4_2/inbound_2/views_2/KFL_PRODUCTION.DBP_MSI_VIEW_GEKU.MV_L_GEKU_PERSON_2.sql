create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_PERSON_2(
	GEKU_PERSON_ID,
	NAME,
	VORNAME,
	ORGA_NR
) as
   SELECT
   geku_person_id
   , NAME
   , vorname
   , orga_nr
   FROM dbp_view.v_l_geku_person_2;