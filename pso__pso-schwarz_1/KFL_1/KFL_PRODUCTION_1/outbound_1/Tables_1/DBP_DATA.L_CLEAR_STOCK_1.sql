--==============================================================
-- Table: l_clear_stock_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_clear_stock_1
   generated from Powerdesigner on Thursday, June 9, 2022 2:14:41 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_clear_stock_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
clear_stock_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Clear-Stock ID that says how to distribute stock. The goal is to change the clear-stock-flag-logic so, that the user has the possibility to use a third option for distributing the DC stock:            1) 0 = do not apply the logic (distribute according to demand in the stores)            2) 1 = distribute the whole blocked stock in DC            3) 2 = distribute the whole stock in DC (blocked stock + free stock)'),
clear_stock_bez STRING(100) OPTIONS(description='Bezeichnungen fuer clear_stock_id.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, clear_stock_id) NOT ENFORCED
)
OPTIONS(description='Lookup table for clear_stock values/options for each mandant. Column clear_stock_id in table ts_wbs_artikel_vz.');