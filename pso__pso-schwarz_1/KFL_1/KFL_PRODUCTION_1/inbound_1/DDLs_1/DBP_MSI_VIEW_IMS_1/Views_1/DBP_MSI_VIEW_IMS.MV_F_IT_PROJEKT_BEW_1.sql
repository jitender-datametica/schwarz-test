CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_F_IT_PROJEKT_BEW_1 AS
-- 03.04.2013 AL Init
-- 22.05.2013 AL Egänzt bereichs_position_it_id
-- 03.06.2013 Abbildung Analyse Projekte
-- 17.02.2014 twie: Analyseprojekte wieder ausbauen, wird nicht mehr verwendet
-- 13.05.2016 twie SPEC0009845: Bis 7.5. wurde Fachbereich in it_projekt_bereich_id geliefert, ab 7.5. in hr_objekt_ebene11_id
-- Um beides auswerten zu können, die Spalten in eine_1 zusammengefügt und das Attribut Fachbereich weiterverwendet
-- Schlüssel von it_projekt_bereich_id um mandant_id erweitert, weil von hr_objekt_ebene11_id benötigt
-- 04.01.2018 SPEC0032265 neue Mappinglogik für die berichts_position_it_id (vorher 7 und 8)

   SELECT
   /*                     CASE WHEN v02.it_projekt_analyse_id IS NOT NULL THEN v02. it_projekt_id
   ELSE v01.it_projekt_id
   END AS it_projekt_id
   */
   v01.it_projekt_id,
   v01.dat_leistung,
   CASE WHEN v01.it_projekt_bereich_id <> '' THEN v01.it_projekt_bereich_id ELSE CAST(CAST(v01.hr_objekt_ebene11_id AS INTEGER) AS CHAR(10)) END AS it_projekt_bereich_id,
   v01.mandant_id,
   CASE
  WHEN v01.it_projekt_bereich_id = 'KIS' OR v01.hr_objekt_ebene11_id = 50551504 THEN 14   -- wenn KIS
  WHEN v01.mandant_id =1 THEN 15   -- wenn nicht KIS, aber DE
  ELSE 16 -- alle anderen
  END AS berichts_position_it_id,
   v01.it_plan_ebene_id,
   v01.stunden_ist,
   v01.stunden_bewertet

  FROM dbp_view.v_it_projekt_bew_1 v01

   /*                                  LEFT JOIN dbp_view.v_it_projekt_1 v02
   ON v01.it_projekt_id = v02.it_projekt_analyse_id
   */

   WHERE v01.extern_fg = 0
;