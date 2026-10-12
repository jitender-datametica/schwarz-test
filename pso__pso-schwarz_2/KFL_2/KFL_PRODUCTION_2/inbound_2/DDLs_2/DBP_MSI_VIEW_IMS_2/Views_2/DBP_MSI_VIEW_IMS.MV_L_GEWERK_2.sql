CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_GEWERK_2 AS
-- 08.04.2016 twie: AP0001938 Lookup für Gewerke mit Dummy_2 -1

   SELECT
   gewerk_id

   FROM dbp_view.v_l_gewerk_2

   UNION

   SELECT
   -1
   FROM dbp_view.v_mandant_2
   WHERE mandant_id = 1;