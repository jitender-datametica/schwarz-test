CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TEKU_MANDANT_ERSTELLER_1 as
   -- LOOKUP Ersteller fuer Fusszeile TEKU Einzel-Berichte
   -- Erweiterung des Attributes Land_1
   -- 2014-10-23 Anpassung Personen
   -- 2016-01-13 Anpassung Personen (PL)

   SELECT
   mandant_id, CASE mandant_id
   WHEN 1 THEN 'Hardy Schwab'
   WHEN 2 THEN 'Jan Roubicek'
   WHEN 3 THEN 'Beata Kisowska'
   WHEN 5 THEN 'Zuzana Kucerova'
   WHEN 6 THEN 'Ivan Blazevic'
   WHEN 7 THEN 'Oana Lazaroiu'
   WHEN 8 THEN 'Mariela Vasileva'
   ELSE 'Unbekannt'
   END::VARCHAR (50) ersteller_bez
   FROM dbp_view.v_mandant_1;