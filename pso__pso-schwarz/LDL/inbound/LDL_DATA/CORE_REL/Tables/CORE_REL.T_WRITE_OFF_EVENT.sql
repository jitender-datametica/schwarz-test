/* --------------------------------------------------------------------------------
   DDL for table: t_write_off_event
   generated from Powerdesigner on Donnerstag, 27. März 2025 10:28:29
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_WRITE_OFF_EVENT CLUSTER BY (BUS_DT)(
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization where the write-off happened. This can be either a store or a delivery company. The type of internal organization is defined by the int_org_type_cd.',
   int_org_type_cd                     VARCHAR(20)     NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
   deliv_company_sid                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the delivery company, to which the write-off is related. In case of a write-off in a warehouse, this is the same as the int_org_sid. In case of a write-off in a store, this is the associated delivery company of the store.',
   country_org_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country organization.',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the related business country. (The business country is not identical to a political country.)',
   real_estate_sid                     NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   logistic_variant_sid                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the logistic variant of a product which is written off.',
   wawi_item_variant_sid               NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item variant which is written off.',
   write_off_dt                        DATE            NOT NULL COMMENT 'The date when the write-off was recorded.',
   bus_dt                              DATE            NOT NULL COMMENT 'The day to which the write-off is accrued.',
   receipt_nr                          NUMBER(38, 0)   NOT NULL COMMENT 'The number of the receipt which tracks the write-off.',
   receipt_line_nr                     NUMBER(38, 0)   NOT NULL COMMENT 'The number of the positon on the receipt which tracks the write-off.',
   correction_seq                      NUMBER(38, 0)   COMMENT 'In case multiple corrections apply to one base record, this is the sequence of the correction.',
   curr_stat_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing, if this is the current record(s) for the given key. Filtering on this flag returns the statistics after any corrections.',
   write_off_event_type_id             NUMBER(38, 0)   NOT NULL COMMENT 'The code identifying the type of write off event. (There are write offs for stores and write offs for warehouses.)',
   write_off_reason_id                 NUMBER(38, 0)   NOT NULL COMMENT 'The identifier for the reason why products are written off.',
   write_off_sales_unit_cnt            NUMBER(38, 0)   COMMENT 'The number of sales variants (contained in this logistic variant) which were written off. In case the product is sold by weight instead of pieces, this attribute is empty.',
   write_off_qty                       NUMBER(38, 5)   COMMENT 'In case the product is sold by weight instead of pieces, this is the quantity of the product which was written off. E.g. 2 kg',
   uom_cd                              VARCHAR(20)     COMMENT 'The code identifying the unit of measure.',
   write_off_net_val                   NUMBER(38, 5)   NOT NULL COMMENT 'The net amount which was written off.',
   curr_cd                             VARCHAR(3)      NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217.',
   part_write_off_fg                   BOOLEAN         NOT NULL COMMENT 'An indicator showing, if the write off was partial or in full.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_WRITE_OFF_EVENT PRIMARY KEY (int_org_sid, bus_dt, write_off_dt, receipt_nr, receipt_line_nr) NOT ENFORCED
 )  COMMENT= 'If products break or for some other reason are considered not suitable for sale any more, they need to be written off.';