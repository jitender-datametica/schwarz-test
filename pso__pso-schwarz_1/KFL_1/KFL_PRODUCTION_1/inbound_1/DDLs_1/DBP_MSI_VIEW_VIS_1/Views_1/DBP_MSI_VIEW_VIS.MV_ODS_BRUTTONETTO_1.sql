CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_BRUTTONETTO_1
AS
   -- Lookup-View für Brutto/Netto Umschaltung
   --

   SELECT
   to_number(dat - CURRENT_DATE) AS brutto_netto_fg, CASE brutto_netto_fg
   WHEN 0 THEN 'Brutto'
   WHEN 1 THEN 'Netto'
   ELSE ''
   END::VARCHAR(20) AS brutto_netto_bez
   FROM dbp_view.v_tag_1
   WHERE dat BETWEEN CURRENT_DATE AND CURRENT_DATE + 1;