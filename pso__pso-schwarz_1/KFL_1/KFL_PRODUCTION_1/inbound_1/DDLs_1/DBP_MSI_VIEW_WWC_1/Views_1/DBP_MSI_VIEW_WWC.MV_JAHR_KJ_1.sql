CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_JAHR_KJ_1
-- 23.08.2018 AP0031942, Umsatzplanung, Erweiterung der Einschränkung auf 3 Jahre in die Zukunft
-- 01.04.2020 NSR0505888, srom0404, telefonische Anforderung Fachbereich, anpassen akt_kj BETWEEN -3 AND 3 (vorher BETWEEN -2 AND 3)
(
kj
,akt_kj
,akt_kj_komplett
)
AS
   SELECT
  kj, akt_kj, akt_kj_komplett

   FROM dbp_view.v_jahr_kj_1
   WHERE akt_kj BETWEEN -3 AND 3;