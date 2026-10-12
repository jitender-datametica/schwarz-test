--==============================================================
-- Table: disposition_rhythmus_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: disposition_rhythmus_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.disposition_rhythmus_spr_zu_2 (
disposition_rhythmus_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Id für den Dispositionsrhythmus (wie oft, an welchen Wochentagen). Gilt auch für den Planungskalender'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1)'),
disposition_rhythmus_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung für den Dispositionsrhythmus (wie oft, an welchen Wochentagen).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='TP408 LVS -Sprachzuordnung  für lfrhy (Dispositionsrhythmus) aus SAP T439H');