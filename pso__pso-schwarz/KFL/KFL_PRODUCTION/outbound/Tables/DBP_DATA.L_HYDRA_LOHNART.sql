--==============================================================
-- Table: l_hydra_lohnart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_hydra_lohnart
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:16:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_hydra_lohnart (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lohnart_id STRING(4) NOT NULL OPTIONS(description='Lohnart/Wage Type  (H100, H200 oder H300)'),
lohnart_bez STRING(30) OPTIONS(description='Bezeichnung der Lohnart (description of the wage type)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lohnart_id) NOT ENFORCED
)
OPTIONS(description='Code and translations for Wage Type(regular salary/base wage, personal bonus, group bonus). Source system is different from the source system that provides data for L_LOHNART and different teams use and manage the two systems independently. So same code might have different meaning in the two systems - this is why we create this "hydra_" trable             We do not have translations in different languages. We have only a description in this table and no _SPR_ZU table');