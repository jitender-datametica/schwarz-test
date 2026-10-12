--==============================================================
-- Table: ereignistyp_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ereignistyp_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ereignistyp_2 (
ereignistyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ereignistyp_2 ID. Ereignistypen sind lokale Feiertage, automatisch generierte Feiertage etc.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ereignistyp_id) NOT ENFORCED
) OPTIONS(description='VIS - Typen von Ereignissen, die auf die Öffnung eines Warenumschlagsplatzes Einfluss haben');