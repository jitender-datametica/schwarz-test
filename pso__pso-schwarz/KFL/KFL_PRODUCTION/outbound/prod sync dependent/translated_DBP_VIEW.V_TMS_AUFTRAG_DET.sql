CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_auftrag_det (mandant_id OPTIONS(description='Mandant im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_auftrag_id
OPTIONS(description='ID des Auftrags (Auftragsnummer). Aus plps.au_nr'), tms_auftrag_unter_id
OPTIONS(description='Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. Aus plps.au_unter_nr'),
tms_auftrag_pos_id
OPTIONS(description='Laufende Nummer zur Identifizierung einer Auftragsposition innerhalb eines Auftrages. Aus plps.au_lfnr'),
tms_auftrag_det_lfd_nr OPTIONS(description='SKey für die Tabelle tms_auftrag_det im Quellsystem. Aus plps.au_lfnr'),
art_id OPTIONS(description='Artikelnummer der Auftragsposition'), orig_art_nr
OPTIONS(description='Artikelnummer der Auftragsposition inklusive aller Zeichen (alphanumerisch und Sonderzeichen), falls vorhanden.'),
menge_kommissioniert OPTIONS(description='Fertig kommissionierte Menge'), status_fertig_cd
OPTIONS(description='Fertig Kennzeichen: F = Kommissionierung abgeschlossen weil entweder ausreichende Menge kommissioniert wurde oder weil der Rest zur Fehlmenge erklärt wurde.'),
tms_transportmittel_id OPTIONS(description='ID des Transportmittels.'), anz_transportmittel
OPTIONS(description='Anzahl des Transportmittels.'), wareneingang_beleg_id
OPTIONS(description='Belegnummer des Wareneingangs, auf T = EBELN.'), dat_wareneingang
OPTIONS(description='Datum des Wareneingangs'), tms_auftrag_orig_id
OPTIONS(description='Originale Auftragsnummer der Auftragsposition, bezieht sich auf SAP Aufträge.'),
tms_auftrag_orig_unter_id
OPTIONS(description='Originale Positionsnummer der Auftragsposition, bezieht sich auf SAP Aufträge.'))
OPTIONS(DESCRIPTION = `TMS - Die Tabelle enthält die relevanten Informationen zu einem Distributionsauftrag auf Positionsebene.`)
AS SELECT mandant_id,
 system_id,
 tms_auftrag_id,
 tms_auftrag_unter_id,
 tms_auftrag_pos_id,
 tms_auftrag_det_lfd_nr,
 art_id,
 orig_art_nr,
 menge_kommissioniert,
 status_fertig_cd,
 tms_transportmittel_id,
 anz_transportmittel,
 wareneingang_beleg_id,
 dat_wareneingang,
 tms_auftrag_orig_id,
 tms_auftrag_orig_unter_id
FROM kfl_production_dbp_data.tms_auftrag_det;