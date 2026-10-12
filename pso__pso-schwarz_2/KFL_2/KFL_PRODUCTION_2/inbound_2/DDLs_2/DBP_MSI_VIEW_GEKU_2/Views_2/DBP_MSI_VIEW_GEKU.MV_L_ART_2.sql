CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_ART_2
(
	ART_ID,
	MANDANT_ID,
	KL_ART_ID
) AS
-- 10.05.2022 twie: SPEC0145413 Lookup Artikel_2
-- 16.08.2022 twie: SPEC0145413 kl_art_id aufnehmen

   SELECT

   art_id
   ,mandant_id
   ,kl_art_id

   FROM dbp_view.v_art_2;