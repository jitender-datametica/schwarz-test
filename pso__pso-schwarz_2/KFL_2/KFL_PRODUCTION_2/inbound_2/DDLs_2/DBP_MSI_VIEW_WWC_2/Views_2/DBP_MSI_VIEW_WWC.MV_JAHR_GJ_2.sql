CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_JAHR_GJ_2
-- 23.08.2018 AP0031942, Umsatzplanung, Erweiterung der Einschränkung auf 2 Jahre in die Zukunft
-- 01.04.2020 NSR0505888, srom0404, telefonische Anforderung Fachbereich, anpassen akt_gj BETWEEN -2 AND 4 (vorher BETWEEN -2 AND 2)
(
gj
,akt_gj
,akt_gj_komplett
)
AS
   SELECT
  gj, akt_gj, akt_gj_komplett

   FROM dbp_view.v_jahr_gj_2
   WHERE akt_gj BETWEEN -2 AND 4;