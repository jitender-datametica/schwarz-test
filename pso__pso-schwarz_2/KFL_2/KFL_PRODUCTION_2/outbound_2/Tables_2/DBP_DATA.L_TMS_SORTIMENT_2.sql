--==============================================================
-- Table: l_tms_sortiment_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_tms_sortiment_2
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_tms_sortiment_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_sortiment_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID desSortiments. Aus plsortim.srtm_nr'),
tms_sortiment_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle l_tms_sortiment_2 im Quellsystem. Ausplsortim.srtm_id'),
tms_sortiment_bez STRING(100) NOT NULL OPTIONS(description='Bezeichnung zum TMS-Sortiment'),
temperaturgruppe_id BIGNUMERIC(38,0) OPTIONS(description='Temperaturgruppe des Sortiments'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_sortiment_id) NOT ENFORCED
)
OPTIONS(description='TMS - Referenztabelle zur Klassifizierung von Waren für verschiedene Sortimente, z. B. Food, O&G, NonFood. Aus der Quelle plsortim (WANKO)');