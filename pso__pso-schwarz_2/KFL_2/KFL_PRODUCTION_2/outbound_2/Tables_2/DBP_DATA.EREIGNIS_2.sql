--==============================================================
-- Table: ereignis_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ereignis_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ereignis_2 (
ereignis_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ereignis_2 ID (fortlaufende Nummer)'),
ereignistyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ereignistyp_2 ID, Gruppierung der Ereignisse in z.Bsp. Allgemeine Feiertage, Sonntagsöffnungen, ...'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
default_offen BIGNUMERIC(38,0) OPTIONS(description='gibt an, ob bei dem Ereignis_2 der Markt normalerweise offen ist'),
sap_ereignis_id BIGNUMERIC(38,0)
OPTIONS(description='Die durch das SAP-System gelieferte ID wird im DWH auf die DWH-interne ID umgesetzt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ereignis_id, ereignistyp_id, mandant_id) NOT ENFORCED
) OPTIONS(description='VIS - Bildet Ereignisse ab, die sich auf den Umsatz auswirken können, wie Feiertage');