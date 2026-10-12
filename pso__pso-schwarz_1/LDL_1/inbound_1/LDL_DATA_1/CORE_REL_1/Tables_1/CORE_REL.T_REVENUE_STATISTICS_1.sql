/* --------------------------------------------------------------------------------
   DDL for table: t_revenue_statistics_1
   generated from Powerdesigner on Mittwoch, 5. April 2023 22:31:14
*/ --------------------------------------------------------------------------------

CREATE TABLE core_rel.T_REVENUE_STATISTICS_1 (
   store_sid                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the store, for which the revenue statistics are generated.',
   country_org_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country_1 organization.',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the related business country. (The business country_1 is not identical to a political country.)',
   real_estate_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   stat_dt                             DATE            NOT NULL COMMENT 'The date when the revenue statistics were collected. ',
   bus_dt                              DATE            NOT NULL COMMENT 'The date for which the revenue is accrued.',
   curr_stat_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing, if this is the current record for the given key, i.e. the record with the latest statistics date. Filtering on this flag returns the statistics after any corrections.',
   correction_seq                      NUMBER(38, 0)   COMMENT 'In case multiple corrections apply to one base record, this is the sequence of the correction.',
   receipt_nr                          NUMBER(38, 0)   NOT NULL COMMENT 'The number of the receipt which tracks the revenue statistics.',
   receipt_line_nr                     NUMBER(38, 0)   NOT NULL COMMENT 'The number of the positon on the receipt which tracks the revenue statistics.',
   stat_src_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code identifying the source or system which provided the statistics.',
   revenue_stat_type_id                NUMBER(38, 0)   NOT NULL COMMENT 'The identifier for the subtype discriminator for revenue statisticss.',
   receipt_cnt                         NUMBER(38, 0)   COMMENT 'The number of receipts generated on this day in this internal organization (store).',
   turnover_net_val                    NUMBER(38, 5)   COMMENT 'The net turnover amount in the currency indicated by the currency code for this day and this internal organization (store). The net turnover is calclated based on the average VAT rate in this store and day.',
   turnover_gross_val                  NUMBER(38, 5)   COMMENT 'The gross turnover amount in the currency indicated by the currency code for this day and this internal organization (store).',
   curr_cd                             VARCHAR(3)      COMMENT 'The code identifying the currency, according to ISO 4217.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_REVENUE_STATISTICS PRIMARY KEY (store_sid, bus_dt, stat_dt, receipt_nr, receipt_line_nr) NOT ENFORCED
 )  COMMENT= 'The event of creating revenue statistics for a particular store and day.';
