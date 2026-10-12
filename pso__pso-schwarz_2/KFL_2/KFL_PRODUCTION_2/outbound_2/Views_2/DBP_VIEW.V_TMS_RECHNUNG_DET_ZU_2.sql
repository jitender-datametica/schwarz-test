CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_rechnung_det_zu_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_rech_beleg_id
OPTIONS(description='ID der Rechnung (Rechnungsnummer). Aus plrpos.beleg_nr'), tms_rech_beleg_pos_id
OPTIONS(description='Rechnungspositionsnummer. Aus plrpos.beleg_posnr'), tms_rech_bezug_lfd_nr
OPTIONS(description='ID der Zuordnung / Referenz im Quellsystem.'), bezugsart_id
OPTIONS(description='ID der Art_2 des Belegbezugs: 0 = undefiniert; 1 = Tour_2; 2 = Tourposition; 3 = Auftrag; 4 = Auftragsposition; 5 = HAU / Gesamtauftrag; 6 = Tag_2; 7 = E_Bordero; 8 = Teil transport; 9 = Gesamtrechnung; 10 = Teil Transport E Bordero; 100 = TRM'),
bezug_schluessel_nr OPTIONS(description='Gesamter Schluessel des Bezugsbelegs.'), tms_ref_nr
OPTIONS(description='Erster Teil des Bezugsbelegs, bspw. Auftrag'), tms_ref_unter_nr
OPTIONS(description='Zweiter Teil des Bezugsbelegs, bspw. Unterauftrag'), tms_ref_pos_nr
OPTIONS(description='Dritter Teil des Bezugsbelegs, bspw. Auftragsposition'))
OPTIONS(DESCRIPTION = `TMS - ZUORDNUNGSTABELLE ZWISCHEN DEN RECHNUNGSPOSITIONEN UND JE NACH BEZUGSART ANDEREN BELEGEN WIE BSPW. AUFTRAGSPOSITIONEN, TOURENPOSITIONEN, GESAMTRECHNUNGEN, ETC.`)
AS SELECT mandant_id,
 system_id,
 tms_rech_beleg_id,
 tms_rech_beleg_pos_id,
 tms_rech_bezug_lfd_nr,
 bezugsart_id,
 bezug_schluessel_nr,
 tms_ref_nr,
 tms_ref_unter_nr,
 tms_ref_pos_nr
FROM kfl_production_dbp_data.tms_rechnung_det_zu_2;