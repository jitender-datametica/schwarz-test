CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WAWI_ITM_PRICE_2 (
   client_id                                COMMENT 'DWH-Mandant_2; FK auf CLIENT; table name before the trans-all migration: client_id'
  ,item_sid                                 COMMENT 'column name before the trans-all migration: item_sid'
  ,pricegroup_id                            COMMENT 'column name before the trans-all migration: pricegroup_id'
  ,dat_valid_from                           COMMENT 'column name before the trans-all migration: dat_valid_from'
  ,dat_valid_until                          COMMENT 'column name before the trans-all migration: dat_valid_until'
  ,vat_id                                   COMMENT 'column name before the trans-all migration: vat_id'
  ,tare_cd                                  COMMENT 'column name before the trans-all migration: tare_cd'
  ,price_retail                             COMMENT 'column name before the trans-all migration: price_retail'
  ,price_retail_net                         COMMENT 'column name before the trans-all migration: price_retail_net'
  ,val_refund                               COMMENT 'column name before the trans-all migration: val_refund'
  ,val_net_refund                           COMMENT 'column name before the trans-all migration: val_net_refund'
  ,val_beverage_tax                         COMMENT 'column name before the trans-all migration: val_beverage_tax'
  ,load_id                                  COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat; table name before the trans-all migration: load_id'
  ,pcwo_reason_id                           COMMENT 'reason identifier for price changes, subset of general set of identifiers of write off and price change reasons
            WAWI:  T201_ITEMPRICES.C201_REASON_ID'
)
COMMENT = ''
AS SELECT
   client_id
  ,item_sid
  ,pricegroup_id
  ,dat_valid_from
  ,dat_valid_until
  ,vat_id
  ,tare_cd
  ,price_retail
  ,price_retail_net
  ,val_refund
  ,val_net_refund
  ,val_beverage_tax
  ,load_id
  ,pcwo_reason_id
FROM P_LEW_CORE.T_WAWI_ITM_PRICE_2
;