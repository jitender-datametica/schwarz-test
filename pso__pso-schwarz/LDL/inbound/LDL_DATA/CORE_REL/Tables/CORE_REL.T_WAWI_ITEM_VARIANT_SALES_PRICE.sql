CREATE TABLE CORE_REL.T_WAWI_ITEM_VARIANT_SALES_PRICE (
   wawi_item_variant_sid               NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item variant.',
   price_grp_sid                       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the price level of a product.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   sales_gross_price                   NUMBER(38, 5)   NOT NULL COMMENT 'The official gross price for which the sales variants which are contained in the given Wawi item variant, are sold.',
   curr_cd                             VARCHAR(3)      NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217.',
   price_reason_cd                     VARCHAR(20)       COMMENT 'The code identifying the reason why a price was defined for a product. E.g. permanent price change, promotional price, etc.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_WAWI_ITEM_VARIANT_SALES_PRICE PRIMARY KEY (wawi_item_variant_sid, price_grp_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity tracks the sales price of a Wawi product variant, depending on the price level. (Note that the Wawi item variant is not the product which is actually sold!)'
  ;  