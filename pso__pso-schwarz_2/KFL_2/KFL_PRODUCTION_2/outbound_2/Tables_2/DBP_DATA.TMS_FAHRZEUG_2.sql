--==============================================================
-- Table: tms_fahrzeug_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_fahrzeug_2
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_fahrzeug_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_fahrzeug_id STRING(20) NOT NULL OPTIONS(description='ID des Fahrzeugs (Fahrzeugnummer). Aus plfaz.nr'),
tms_fahrzeug_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle tms_fahrzeug_2 im Quellsystem. Aus plfaz.faz_id'),
tms_fahrzeugtyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fahrzeugtyp'),
tms_fahrzeug_trailer_id STRING(20) OPTIONS(description='Hängernummer 1'),
spediteur_tms_gp_id STRING(30) OPTIONS(description='ID des tms_gp_2, welcher hier als Spediteur auftrifft'),
spediteur_tms_gp_typ_cd STRING(3)
OPTIONS(description='Code für den tms_gp_2-Typ, welcher hier als Spediteur auftrifft. immer "S" (Typ = S Spediteur)'),
verbrauch_pro_100km NUMERIC(5,2) OPTIONS(description='Verbrauch pro 100 Km'),
tms_treibstoff_id BIGNUMERIC(38,0) OPTIONS(description='Treibstoffart (Diesel, Benzin, usw.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_fahrzeug_id) NOT ENFORCED
)
OPTIONS(description='TMS - Die Tabelle enthält Informationen über die Fahrzeuge im System, einschließlich Fahrzeugtyp, Spediteur, Anhänger und Verbrauchsinformationen. Es handelt sich um konkrete Fahrzeuge (bei KFL vmtl. eher generische Objekte wie z. B. "Elektro-LKW" oder "LKW Diesel 40t"). Aus der Quelle plfaz (WANKO)');