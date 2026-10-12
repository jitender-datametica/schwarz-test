/* --------------------------------------------------------------------------------
   DDL for table: t_wawi_inventory_result_2
   generated from Powerdesigner on Dienstag, 29. April 2025 19:23:14
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_WAWI_INVENTORY_RESULT_2 CLUSTER BY (INV_DT)(
   inv_sid                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the inventory event.',
   wawi_item_sid                       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   inv_dt                              DATE            NOT NULL COMMENT 'The date when the inventory is carried out.',
   inv_type_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code identifying the subtype discriminator for inventories.',
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
   int_org_type_cd                     VARCHAR(20)     COMMENT 'The code identifying the discriminators for internal organizations.',
   country_org_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country_2 organization.',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the related business country. (The business country_2 is not identical to a political country.)',
   inv_sales_unit_cnt                  NUMBER(38, 5)   COMMENT 'The number of individual items (which belong to the given Wawi item_2) which are actually on stock. E.g. if there are two boxes with 20 items each, the stock count is 40. For weight-based products this attribute is empty.',
   inv_diff_sales_unit_cnt             NUMBER(38, 5)   COMMENT 'The inventory difference, expressed as the number of individual items (that belong to the given Wawi item_2). The inventory difference is the difference between the counted value and the calculated stock value. For weight-based products this attribute is empty.',
   inv_qty                             NUMBER(38, 5)   COMMENT 'The weight of the product which is actually on stock, expressed in the indicated unit_2 of measure. (This attribute is only filled for weight-based products.)',
   inv_diff_qty                        NUMBER(38, 5)   COMMENT 'The inventory difference, expressed in the indicated unit_2 of measure. The inventory difference is the difference between the counted value and the calculated stock value. This attribute is only filled for weight-based products.',
   uom_cd                              VARCHAR(20)     COMMENT 'The code identifying the unit_2 of measure for the inventory quantity.',
   inv_prod_reason_id                  NUMBER(38, 0)   COMMENT 'The identifier for the reason why an inventory was initiated for a certain product.',
   inv_result_status_type_id           NUMBER(38, 0)   COMMENT 'The identifier for the counting status_2 of an inventory result. It shows, if the product could be counted.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_WAWI_INVENTORY_RESULT PRIMARY KEY (wawi_item_sid, inv_sid, dwh_valid_from_tmsp) NOT ENFORCED
)  COMMENT= 'The inventory process produces counts for each Wawi item. The inventory result is shown either in kilograms (or any other unit_2 of measure describing the weight) or as the number of sales_2 variants of the respective Wawi item. So if there are two boxes with 20 sales_2 item_2 each, the inventory count is 40.';
