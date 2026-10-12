CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_GEWERK AS
-- 08.04.2016 twie: AP0001938 Lookup für Gewerke mit Dummy -1

   SELECT
   gewerk_id

   FROM dbp_view.v_l_gewerk

   UNION

   SELECT
   -1
   FROM dbp_view.v_mandant
   WHERE mandant_id = 1;