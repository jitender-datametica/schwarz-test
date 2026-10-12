--==============================================================
-- Table: geku_crm_status_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_crm_status_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_crm_status_zu_2 (
geku_crm_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='GEKU - Mapping ID'),
geku_status_id BIGNUMERIC(38,0)
OPTIONS(description='eindeutige ID des Ticketstatus (erledigt, eskaliert, in Arbeit, überfällig)'),
crm_status_id BIGNUMERIC(38,0) OPTIONS(description='Ticket Status_2 ID z. B. Abgeschlossen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_crm_status_id) NOT ENFORCED
) OPTIONS(description='GEKU - Mapping Tabelle Status_2 Geku zu CRM');