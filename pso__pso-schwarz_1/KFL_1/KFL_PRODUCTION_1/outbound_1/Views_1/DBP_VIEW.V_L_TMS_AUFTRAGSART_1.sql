CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_tms_auftragsart_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_auftragsart_id
OPTIONS(description='ID der Auftragsart. Aus plini.entry'), tms_auftragsart_lfd_nr
OPTIONS(description='SKey für die Tabelle l_tms_auftragsart_1 im Quellsystem. Aus plini.ini_id'), tms_auftragsart_bez
OPTIONS(description='Bezeichnung zur Auftragsart'))
OPTIONS(DESCRIPTION = `TMS - REFERENZTABELLE ZUR KLASSIFIZIERUNG VON TMS AUFTRÄGEN MIT EINDEUTIGEN BEZEICHNUNGEN UND BESCHREIBUNGEN FÜR VERSCHIEDENE AUFTRAGSARTEN. AUS DER QUELLE PLINI (WANKO)`)
AS SELECT mandant_id,
 system_id,
 tms_auftragsart_id,
 tms_auftragsart_lfd_nr,
 tms_auftragsart_bez
FROM kfl_production_dbp_data.l_tms_auftragsart_1;