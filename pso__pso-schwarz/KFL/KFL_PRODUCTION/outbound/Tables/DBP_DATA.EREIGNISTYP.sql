--==============================================================
-- Table: ereignistyp
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ereignistyp
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ereignistyp (
ereignistyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ereignistyp ID. Ereignistypen sind lokale Feiertage, automatisch generierte Feiertage etc.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ereignistyp_id) NOT ENFORCED
) OPTIONS(description='VIS - Typen von Ereignissen, die auf die Öffnung eines Warenumschlagsplatzes Einfluss haben');