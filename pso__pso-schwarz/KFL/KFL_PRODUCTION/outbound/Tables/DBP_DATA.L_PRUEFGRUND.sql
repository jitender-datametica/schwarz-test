--==============================================================
-- Table: l_pruefgrund
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_pruefgrund
   generated from Powerdesigner on Mittwoch, 21. Februar 2024 15:29:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_pruefgrund (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschluessel'),
z_arbeitsgebiet_id BIGNUMERIC(38,0) DEFAULT 1 NOT NULL
OPTIONS(description='ID der Arbeitsgebiete. Ein Arbeitsgebiet steht für die Nachrichtenklasse zu der die Nachricht gehört. Aktuell gibt es folgende Arbeitsgebiete: 0 = Z_FRE,  1 = Z_EMON und 4 = EWM. '),
pruef_id STRING(3) NOT NULL OPTIONS(description='Arbeitsgebiet. Pruefungsgrund ID'),
pruef_bez STRING(80) COLLATE 'und:ci'
OPTIONS(description='Sprachabhängige Bezeichnung des Pruefungsgrundes innerhalb des Arbeitsgebietes.'),
vis_pruef_bez STRING(80)
OPTIONS(description='Sprachabhängige Bezeichnung des Pruefungsgrundes innerhalb des Arbeitsgebietes.. Kann für VIS angepasst werden und von der eigentlichen Bezeichnung abweichen um ein besseres Verständnis der Endanwender innerhalb von VIS zu erzeugen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pruef_id, mandant_id, z_arbeitsgebiet_id, spr_id) NOT ENFORCED
) OPTIONS(description='F&R Look-Up für die Pruefgruende der Ausnahmen');