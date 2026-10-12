create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_AUSGABEGRUND_1(
	AUSGEBER_ID,
	MANDANT_ID
) as
-- 11.02.2016 twie: Lookup Ausgabegrund für Gutschein_1

   SELECT

   ausgeber_id
   , mandant_id

   FROM dbp_view.v_l_ausgeber_1

   --nur GEKU relevante
   WHERE (ausgeber_id = 'KDM004'
   OR ausgeber_id = 'KDM005' );