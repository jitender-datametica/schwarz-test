CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_F_IT_PROJEKT_PLAN_DET AS
-- 04.04.2013 AL Init (Daten aus WKB Eingabeblatt Kosten)
-- 22.04.2013 AL Kapitalkosten
-- 03.05.2013 AL Abbilden von AHK / Aufwand
-- 20.05.2013 AL AHK, EA für Software und Hardware
-- 15.09.2013 AL Bei der Berechnung Kapitalkosten, soll auf Position 11 keinen sonstiger
--                    Aufwand darauf gerechnet werden.
-- 17.02.2014 twie: Analyseprojekte wieder ausbauen, wird nicht mehr verwendet
-- 15.08.2014 twie: Bei berichts_position_it_id = 3 (Sonstige Investitionen) nicht mehr komplett auf AHK sondern anhand ahk_ea_kz aufteilen
-- 18.10.2017 twie: RITM0413850 Umbenennung ahk_ea_kz zu ahk_aufwand_kz
-- 19.10.2017 twie: RITM0414617 plan_betrag_freigegeben entfällt, deshalb ersetzt durch plan_betrag (inhaltsgleich)
--                    aktivierungsquote_intern in Tabelle ersetzt durch aktivierungsquote_intern_plan, ebenso bei extern
-- 24.10.2017 twie: SPEC0029703 Neue Felder plan_betrag_betrieb und ahk_quote; CASE Logik für plan_aufwand_betrag und plan_ahk_betrag entfält, kommt stattdessen aus neuen Feldern aufwand_euro und ahk_euro; Unions mit Kapitelkosten und Sonstiger Aufwand entfallen komplett
-- 03.01.2019 twie: SPEC0046436 Umbau der Stuktur auf neue Tabelle, befüllt aus Clarity. Dadurch auch Änderung der meisten Kennzahlen

   SELECT
   v01.plan_revision_id AS plan_version_id,
   v01.it_projekt_id,
   v01.sparte_id,
   v01.gj,
   v01.berichts_position_it_id,
   v01.plan_betrag,
   v01.plan_betrag_betrieb,
   v01.aufwand_euro AS plan_aufwand_betrag,
   v01.ahk_euro AS plan_ahk_betrag

   FROM dbp_view.v_it_projekt_plan_det  v01
;