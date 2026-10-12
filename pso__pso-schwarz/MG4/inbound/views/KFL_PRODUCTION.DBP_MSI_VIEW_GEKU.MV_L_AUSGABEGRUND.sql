create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_AUSGABEGRUND(
	AUSGEBER_ID,
	MANDANT_ID
) as
-- 11.02.2016 twie: Lookup Ausgabegrund für Gutschein

   SELECT

   ausgeber_id
   , mandant_id

   FROM dbp_view.v_l_ausgeber

   --nur GEKU relevante
   WHERE (ausgeber_id = 'KDM004'
   OR ausgeber_id = 'KDM005' );