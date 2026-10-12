create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_L_ART(
	ART_ID,
	MANDANT_ID,
	KL_ART_ID
) as
-- 10.05.2022 twie: SPEC0145413 Lookup Artikel
-- 16.08.2022 twie: SPEC0145413 kl_art_id aufnehmen

   SELECT

   art_id
   ,mandant_id
   ,kl_art_id

   FROM dbp_view.v_art;