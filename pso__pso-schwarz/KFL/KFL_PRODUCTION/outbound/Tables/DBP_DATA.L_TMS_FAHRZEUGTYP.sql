--==============================================================
-- Table: l_tms_fahrzeugtyp
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_fahrzeugtyp
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_tms_fahrzeugtyp (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_fahrzeugtyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Fahrzeugtyps (Fahrzeugtypnummer). Aus plfaztyp.faztyp_nr'),
tms_fahrzeugtyp_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle l_tms_fahrzeugtyp im Quellsystem. Aus plfaztyp.faztyp_id'),
tms_fahrzeugtyp_bez STRING(20) NOT NULL OPTIONS(description='Bezeichnung zum Fahrzeugtyp'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_fahrzeugtyp_id) NOT ENFORCED
)
OPTIONS(description='TMS - Referenztabelle zur Klassifizierung von Fahrzeugen für verschiedene Fahrzeugtypen, z. B. Zugmaschine, Auflieger, LKW, Anhänger. Aus der Quelle plfaztyp (WANKO)');