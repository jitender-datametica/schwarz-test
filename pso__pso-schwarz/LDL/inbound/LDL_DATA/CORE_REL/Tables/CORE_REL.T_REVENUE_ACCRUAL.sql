/* --------------------------------------------------------------------------------
   DDL for table: t_revenue_accrual
   generated from Powerdesigner on Mittwoch, 5. April 2023 22:31:14
*/ --------------------------------------------------------------------------------

CREATE TABLE core_rel.T_REVENUE_ACCRUAL (
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization to which the revenue is accrued.',
   int_org_type_cd                     VARCHAR(20)     NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
   country_org_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country organization.',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the related business country. (The business country is not identical to a political country.)',
   real_estate_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   accrual_dt                          DATE            NOT NULL COMMENT 'The day when the the revenue was accrued',
   bus_dt                              DATE            NOT NULL COMMENT 'The day for which the revenue is accrued.',
   curr_accrual_fg                     BOOLEAN         NOT NULL COMMENT 'An indicator showing, if this is the current record for the given key, i.e. the record with the latest accrual date. Filtering on this flag returns the revenue accruals after any corrections.',
   receipt_cnt                         NUMBER(38, 0)   COMMENT 'The number of receipts generated on this day in this internal organization (store).',
   turnover_net_val                    NUMBER(38, 5)   COMMENT 'The accrued net amount in the currency indicated by the currency code.',
   curr_cd                             VARCHAR(3)      COMMENT 'The code identifying the currency, according to ISO 4217.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_REVENUE_ACCRUAL PRIMARY KEY (int_org_sid, bus_dt, accrual_dt) NOT ENFORCED
 )  COMMENT= 'In the mid of the following month, the reconciled revenue for all days of the previous month is accrued to stores. The amounts resulting from cash register events are adjusted for commissions resulting from goods on consignment.';
