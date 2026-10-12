--==============================================================
-- Table: kmr_l_pruefung_bereich_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_pruefung_bereich_2
   generated from Powerdesigner on Mittwoch, 14. August 2024 15:12:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_l_pruefung_bereich_2 (
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.'),
pruefung_bereich_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zu berücksichtigende Bereiche / Code of area which should be considered / revisioned in a quick audit / "Kurzcheck". For other audit types these codes are not applicable.'),
pruefung_bereich_bez STRING(255) NOT NULL
OPTIONS(description='Zu berücksichtigende Bereiche / Name of area which should be considered / revisioned in a quick audit / "Kurzcheck". For other audit types these names are not applicable.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pruefung_bereich_id, amx_system_id) NOT ENFORCED
)
OPTIONS(description='KMR - Lookup table for the areas that have to be cosidered for a "Kurzcheck". Source view: v_dwh_kl_data_guideline.');