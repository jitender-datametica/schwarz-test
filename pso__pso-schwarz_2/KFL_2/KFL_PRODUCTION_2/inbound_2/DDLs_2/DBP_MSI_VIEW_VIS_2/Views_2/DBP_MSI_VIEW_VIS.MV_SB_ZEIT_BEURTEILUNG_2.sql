CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_ZEIT_BEURTEILUNG_2
AS
   -- LOOKUP Schnellbeurteilung Zeitintervalle fuer Schwellwerte
   -- 20120419 komplett ueberarbeitet
   -- 2012KW28 Zuordnung ueber Zeit_2-Tabelle

   SELECT
   v01.zeit_stunde, v02.zeit_stunde_von, v02.zeit_stunde_bis2 AS zeit_stunde_bis
   --, (v02.zeit_stunde_von * 10000::INTEGER (FORMAT '99:99:99')) AS sb_zeit_von
   --, (v02.zeit_stunde_bis2 * 10000 + 5959::INTEGER (FORMAT '99:99:99')) AS sb_zeit_bis
   --, TRIM(v02.zeit_stunde_von (FORMAT '99')) || ':00 - ' || TRIM(zeit_stunde_bis2 (FORMAT '99')) || ':59'::VARCHAR(15) AS sb_zeit_bez
   ,(to_time(v02.zeit_stunde_von::varchar || ':00:00')) AS sb_zeit_von
   ,(to_time(v02.zeit_stunde_bis2::varchar || ':59:59')) AS sb_zeit_bis
   ,substring((to_time(v02.zeit_stunde_von::varchar || ':00:00')),1,2)::varchar || ':00 - ' || substring((to_time(zeit_stunde_bis2::varchar || ':00:00')),1,2)::varchar || ':59' as sb_zeit_bez
   FROM dbp_view.v_zeit_2 v01

   JOIN
   (
   SELECT DISTINCT
   zeit_stunde_von, zeit_stunde_bis, CASE WHEN zeit_stunde_bis = 24 THEN 23 ELSE zeit_stunde_bis END zeit_stunde_bis2
   FROM dbp_view.v_sb_schwellwert_zeit_2
   ) v02
   ON v01.zeit_stunde BETWEEN v02.zeit_stunde_von AND v02.zeit_stunde_bis2

   WHERE v01.zeit_minute = 0;