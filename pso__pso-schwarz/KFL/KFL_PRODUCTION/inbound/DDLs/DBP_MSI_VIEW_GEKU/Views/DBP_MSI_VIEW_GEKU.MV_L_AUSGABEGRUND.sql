CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_AUSGABEGRUND
AS
-- 11.02.2016 twie: Lookup Ausgabegrund für Gutschein

   SELECT

   ausgeber_id
   , mandant_id

   FROM dbp_view.v_l_ausgeber

   --nur GEKU relevante
   WHERE (ausgeber_id = 'KDM004'
   OR ausgeber_id = 'KDM005' );