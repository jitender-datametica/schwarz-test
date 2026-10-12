create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_AUSGABEGRUND_2(
	AUSGEBER_ID,
	MANDANT_ID
) as
-- 11.02.2016 twie: Lookup Ausgabegrund für Gutschein_2

   SELECT

   ausgeber_id
   , mandant_id

   FROM dbp_view.v_l_ausgeber_2

   --nur GEKU relevante
   WHERE (ausgeber_id = 'KDM004'
   OR ausgeber_id = 'KDM005' );