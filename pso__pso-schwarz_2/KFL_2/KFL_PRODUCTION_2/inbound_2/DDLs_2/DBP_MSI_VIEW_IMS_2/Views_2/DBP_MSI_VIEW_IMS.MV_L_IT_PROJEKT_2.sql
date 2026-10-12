CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_IT_PROJEKT_2 AS
-- 03.04.2013 AL Init
-- 02.05.2013 AL Analyse Projekt ergänzt
-- 03.06.2013 AL Folgeprojekt hinzugefügt (dient Ausschluss Analyseprojekte in FE)
-- 17.02.2014 twie: Analyseprojekte wieder ausbauen, wird nicht mehr verwendet
-- 22.10.2018 twie: NSR0269870 Nur Projekte anzeigen, die auch in der Tabelle in_projekt_2 exisitieren, um SDL Projekte auszuschließen
-- 13.11.2018 twie: NSR0422166 Join auf in_projekt_2 wieder entfernen, da zu viele Projekte ausgeschlossen werden
-- 20.11.2018 twie: SPEC0042120 17 weitere Felder aus Tabelle aufnehmen

   SELECT
   v01.it_projekt_id,
   v01.it_projekt_bez,
   v01.it_projekt_status_id,
   v01.it_gremium_id,
   v01.it_projektart_id,
   v01.verrechnung_fg,
   v01.dat_projekt_start,
   v01.dat_projekt_ende,
   v01.dat_bericht_start,
   v01.dat_bericht_ende,
   v01.einnahmen_entw_initial,
   v01.einsparungen_entw_initial,
   v01.einnahmen_betr_lfd_jahr1,
   v01.einsparungen_betr_lfd_jahr1,
   v01.einnahmen_betr_lfd_jahr2,
   v01.einsparungen_betr_lfd_jahr2,
   v01.einnahmen_betr_lfd_jahr3,
   v01.einsparungen_betr_lfd_jahr3,
   v01.einnahmen_betr_lfd_jahr4,
   v01.einsparungen_betr_lfd_jahr4,
   v01.einnahmen_betr_lfd_jahr5,
   v01.einsparungen_betr_lfd_jahr5,
   v01.einnahmen_betr_lfd_jahr6,
   v01.einsparungen_betr_lfd_jahr6,
   v01.einnahmen_betr_lfd_jahr7,
   v01.einsparungen_betr_lfd_jahr7,
   v01.nutzen_plan

   FROM dbp_view.v_it_projekt_2  v01
;