--==============================================================
-- Table: l_cpr_suchfeld
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_cpr_suchfeld
   generated from Powerdesigner on Dienstag, 27. Juni 2023 17:55:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_cpr_suchfeld (
cpr_suchfeld_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert'),
cpr_suchfeld STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Aus der Quelle geliefertes Suchfeld'),
cpr_suchfeld_akt_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL OPTIONS(description='aktiv genutzte Suchfelder'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (cpr_suchfeld_id) NOT ENFORCED
) OPTIONS(description='IOS - Lookuptabelle für das zentrals C-Projects-Suchfeld');