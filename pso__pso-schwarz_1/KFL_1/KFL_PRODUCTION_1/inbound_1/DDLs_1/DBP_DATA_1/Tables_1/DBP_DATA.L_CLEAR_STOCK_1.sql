--==============================================================
-- Table: l_clear_stock_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_clear_stock_1
   generated from Powerdesigner on Thursday, June 9, 2022 2:14:41 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_CLEAR_STOCK_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH.',
   clear_stock_id                      NUMBER(38,0)    NOT NULL COMMENT 'Clear-Stock ID that says how to distribute stock. The goal is to change the clear-stock-flag-logic so, that the user has the possibility to use a third option for distributing the DC stock:
            1) 0 = do not apply the logic (distribute according to demand in the stores)
            2) 1 = distribute the whole blocked stock in DC
            3) 2 = distribute the whole stock in DC (blocked stock + free stock)',
   clear_stock_bez                     VARCHAR(100)    COMMENT 'Bezeichnungen fuer clear_stock_id.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_CLEAR_STOCK PRIMARY KEY (mandant_id, clear_stock_id) NOT ENFORCED
)  COMMENT = 'Lookup table for clear_stock values/options for each mandant. Column clear_stock_id in table ts_wbs_artikel_vz.';
