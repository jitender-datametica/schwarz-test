/* --------------------------------------------------------------------------------
   DDL for table: t_daily_vat_statistics
   generated from Powerdesigner on Mittwoch, 5. April 2023 22:31:14
*/ --------------------------------------------------------------------------------

CREATE TABLE core_rel.T_DAILY_VAT_STATISTICS (
   store_sid                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the store, in which the end-of-day processing happens.',
   country_org_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the related country organization.',
   country_org_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code of the related business country. (The business country is not identical to a political country.)',
   real_estate_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   stat_dt                             DATE            NOT NULL COMMENT 'The date when the VAT statistics were collected. ',
   bus_dt                              DATE            NOT NULL COMMENT 'The business date for which the VAT statistics are generated.',
   curr_stat_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing, if this is the current record for the given key, i.e. the record with the latest statistics date. Filtering on this flag returns the statistics after any corrections.',
   geo_area_sid                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the geographical area to which the tax class applies.',
   tax_class_cd                        VARCHAR(20)     NOT NULL COMMENT 'The code for the tax class, e.g. Reduced VAT Rate.',
   vat_stat_calc_method_cd             VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way, how the VAT statistics have been calculated.',
   turnover_gross_val                  NUMBER(38, 5)   NOT NULL COMMENT 'The gross turnover in the currency indicated by the currency code, for this store and time period which is taxed with the given VAT class.',
   vat_val                             NUMBER(38, 5)   NOT NULL COMMENT 'The resulting VAT amout in the currency indicated by the currency code, for the given store, time period and VAT class.',
   curr_cd                             VARCHAR(3)      NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DAILY_VAT_STATISTICS PRIMARY KEY (store_sid, real_estate_sid, bus_dt, stat_dt, geo_area_sid, tax_class_cd, vat_stat_calc_method_cd) NOT ENFORCED
 )  COMMENT= 'The event of creating VAT statistics for a given store and a day, showing the gross turnover and the VAT amount for each applicable VAT class.';
