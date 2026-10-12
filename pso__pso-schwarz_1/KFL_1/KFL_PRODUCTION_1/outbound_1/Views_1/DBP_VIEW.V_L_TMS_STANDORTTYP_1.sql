CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_tms_standorttyp_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_standorttyp_id
OPTIONS(description='ID des Standorttyps. Aus plini.entry'), tms_standorttyp_lfd_nr
OPTIONS(description='SKey für die Tabelle l_tms_standort_typ im Quellsystem. Aus plini.ini_id'), tms_standorttyp_bez
OPTIONS(description='Bezeichnung zum Standorttyp (z. B. Frühmarkt, Lieferant, EWM Lager, usw)'))
OPTIONS(DESCRIPTION = `TMS - REFERENZTABELLE ZUR KLASSIFIZIERUNG VON STANDORTEN FÜR VERSCHIEDENE STANDORTTYPEN (Z. B. FRÜHMARKT, LIEFERANT, EWM LAGER, USW). AUS DER QUELLE PLINI (WANKO)`)
AS SELECT mandant_id,
 system_id,
 tms_standorttyp_id,
 tms_standorttyp_lfd_nr,
 tms_standorttyp_bez
FROM kfl_production_dbp_data.l_tms_standorttyp_1;