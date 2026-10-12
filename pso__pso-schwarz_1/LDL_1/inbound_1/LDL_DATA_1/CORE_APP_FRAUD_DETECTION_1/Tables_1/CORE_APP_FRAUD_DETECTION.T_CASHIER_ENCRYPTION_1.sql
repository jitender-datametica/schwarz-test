/* --------------------------------------------------------------------------------
   DDL for table: t_cashier_encryption_1
   generated from Powerdesigner on Mittwoch, 14. August 2024 15:08:47
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_APP_FRAUD_DETECTION.T_CASHIER_ENCRYPTION_1 (
   cashier_hash                        VARCHAR(32)     NOT NULL COMMENT 'Pseudonymization via country_1 ISO code, store number, cashier number, date (e.g. DE | 1207 | 04 | 2024-04-06) via MD5.',
   bus_dt                              DATE            NOT NULL COMMENT 'The business date on which the retail event happend.',
   store_nr                            VARCHAR(20)     NOT NULL COMMENT 'Natural key of the store the was valid point in time of the hashing or the store number which appear in the receipt (as internal organization). ',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the related business country. (The business country_1 is not identical to a political country.)',
   cashier_nr                          VARCHAR(20)     NOT NULL COMMENT 'The number which identifies the cashier. (The number is unique for a given store and a day.)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT AK_AK_T_CASHIE UNIQUE (bus_dt, store_nr, country_org_cd, cashier_nr) NOT enforced,
   CONSTRAINT PK_T_CASHIER_ENCRYPTION PRIMARY KEY (cashier_hash) NOT ENFORCED
)  COMMENT= 'A line, which logs the sale or return of a single product within a retail event.';
