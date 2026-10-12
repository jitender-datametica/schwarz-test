--==============================================================
-- Table: ereignis
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ereignis
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ereignis (
ereignis_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ereignis ID (fortlaufende Nummer)'),
ereignistyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ereignistyp ID, Gruppierung der Ereignisse in z.Bsp. Allgemeine Feiertage, Sonntagsöffnungen, ...'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
default_offen BIGNUMERIC(38,0) OPTIONS(description='gibt an, ob bei dem Ereignis der Markt normalerweise offen ist'),
sap_ereignis_id BIGNUMERIC(38,0)
OPTIONS(description='Die durch das SAP-System gelieferte ID wird im DWH auf die DWH-interne ID umgesetzt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ereignis_id, ereignistyp_id, mandant_id) NOT ENFORCED
) OPTIONS(description='VIS - Bildet Ereignisse ab, die sich auf den Umsatz auswirken können, wie Feiertage');