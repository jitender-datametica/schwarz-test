/* --------------------------------------------------------------------------------
   DDL for table: t_wawi_itm_price_2
   generated from Powerdesigner on Dienstag, 21. November 2023 20:00:47
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_WAWI_ITM_PRICE_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT; table name before the trans-all migration: client_id',
   item_sid                            NUMBER(38,0)    NOT NULL COMMENT 'column name before the trans-all migration: item_sid',
   pricegroup_id                       NUMBER(8,0)     NOT NULL COMMENT 'column name before the trans-all migration: pricegroup_id',
   dat_valid_from                      DATE            NOT NULL COMMENT 'column name before the trans-all migration: dat_valid_from',
   dat_valid_until                     DATE            NOT NULL COMMENT 'column name before the trans-all migration: dat_valid_until',
   vat_id                              NUMBER(38,0)    NOT NULL COMMENT 'column name before the trans-all migration: vat_id',
   tare_cd                             NUMBER(38,0)    COMMENT 'column name before the trans-all migration: tare_cd',
   price_retail                        NUMBER(18,4)    COMMENT 'column name before the trans-all migration: price_retail',
   price_retail_net                    NUMBER(19,5)    COMMENT 'column name before the trans-all migration: price_retail_net',
   val_refund                          NUMBER(18,4)    COMMENT 'column name before the trans-all migration: val_refund',
   val_net_refund                      NUMBER(19,5)    COMMENT 'column name before the trans-all migration: val_net_refund',
   val_beverage_tax                    NUMBER(18,4)    COMMENT 'column name before the trans-all migration: val_beverage_tax',
   load_id                             NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat; table name before the trans-all migration: load_id',
   pcwo_reason_id                      NUMBER(38,0)    COMMENT 'reason identifier for price changes, subset of general set of identifiers of write off and price change reasons
                        WAWI:  T201_ITEMPRICES.C201_REASON_ID',   
   CONSTRAINT PK_T_WAWI_ITM_PRICE PRIMARY KEY (item_sid, pricegroup_id, dat_valid_from, dat_valid_until) NOT ENFORCED 
)  COMMENT = 'data from WAWI table T201_ITEMPRICES_2 ';
