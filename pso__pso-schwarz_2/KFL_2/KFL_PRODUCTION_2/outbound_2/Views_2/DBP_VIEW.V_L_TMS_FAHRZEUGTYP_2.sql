CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_tms_fahrzeugtyp_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_fahrzeugtyp_id
OPTIONS(description='ID des Fahrzeugtyps (Fahrzeugtypnummer). Aus plfaztyp.faztyp_nr'), tms_fahrzeugtyp_lfd_nr
OPTIONS(description='SKey für die Tabelle l_tms_fahrzeugtyp_2 im Quellsystem. Aus plfaztyp.faztyp_id'),
tms_fahrzeugtyp_bez OPTIONS(description='Bezeichnung zum Fahrzeugtyp'))
OPTIONS(DESCRIPTION = `TMS - REFERENZTABELLE ZUR KLASSIFIZIERUNG VON FAHRZEUGEN FÜR VERSCHIEDENE FAHRZEUGTYPEN, Z. B. ZUGMASCHINE, AUFLIEGER, LKW, ANHÄNGER. AUS DER QUELLE PLFAZTYP (WANKO)`)
AS SELECT mandant_id,
 system_id,
 tms_fahrzeugtyp_id,
 tms_fahrzeugtyp_lfd_nr,
 tms_fahrzeugtyp_bez
FROM kfl_production_dbp_data.l_tms_fahrzeugtyp_2;