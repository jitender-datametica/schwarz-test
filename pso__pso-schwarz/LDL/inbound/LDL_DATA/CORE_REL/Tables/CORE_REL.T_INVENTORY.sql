/* --------------------------------------------------------------------------------
   DDL for table: t_inventory
   generated from Powerdesigner on Dienstag, 3. Dezember 2024 16:50:44
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INVENTORY (
   inv_sid                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the inventory event.',
   inv_dt                              DATE            NOT NULL COMMENT 'The date when the inventory is carried out.',
   inv_type_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code identifying the subtype discriminator for inventorys.',
   inv_nr                              NUMBER(38, 0)   NOT NULL COMMENT 'The number which identifies the inventory event in a given country.',
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization for which the inventory is done.',
   int_org_type_cd                     VARCHAR(20)     NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
   country_org_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country organization.',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the related business country. (The business country is not identical to a political country.)',
   inv_period_start_dt                 DATE            COMMENT 'The inventory period is the business period between last full inventory and the current inventory. This attribute is the start date of this period.',
   inv_period_end_dt                   DATE            COMMENT 'The inventory period is the business period between last full inventory and the current inventory. This attribute is the end date of this period.',
   inv_reason_id                       NUMBER(38, 0)   COMMENT 'The identifier for the reason why an inventory was initiated.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_INVENTORY PRIMARY KEY (inv_sid) NOT ENFORCED
)  COMMENT= 'An inventory event is the process of counting the number of products that are on stock in a given store or warehouse (delivery company). The result of an inventory may correct the calculated stock.';
