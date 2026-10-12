/* --------------------------------------------------------------------------------
   DDL for table: t_country_statistics_by_month_2
   generated from Powerdesigner on Dienstag, 5. März 2024 21:06:22
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_COUNTRY_STATISTICS_BY_MONTH_2 (
   reporting_country_sid               NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the reporting country. (i.e. a country_2 definition which is different from a geographical country_2)',
   stat_type_cd                        VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of metric which is calculated for the reporting country.',
   stat_dt                             DATE            NOT NULL COMMENT 'The date when the statistics were collected. ',
   cal_month                           NUMBER(38, 0)   NOT NULL COMMENT 'The identifier of a calendar_2 month in the form YYYYMM. E.g. 202101 für January 2021.',
   curr_stat_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing, if this is the current record(s) for the given key, Filtering on this flag returns the statistics after any corrections.',
   stat_val                            NUMBER(38, 5)   COMMENT 'The calculated statistics amount for the given month, statistics type and reporting country. (Depending on the statistics type this may be a net or a gross value.)',
   curr_cd                             VARCHAR(3)      COMMENT 'The code identifying the currency, according to ISO 4217.',
   stat_cnt                            NUMBER(38, 0)   COMMENT 'The calculated statistics count for the given month, statistics type and reporting country.',
   stat_qty                            NUMBER(38, 5)   COMMENT 'The calculated statistics quantity for the given month, statistics type and reporting country.',
   stat_meas                           NUMBER(38, 5)   COMMENT 'The calculated statistics measure for the given month, statistics type and reporting country.',
   uom_cd                              VARCHAR(20)     COMMENT 'The code identifying the unit_2 of measure for the statistics measure.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_COUNTRY_STATISTICS_BY_MONTH PRIMARY KEY (reporting_country_sid, stat_dt, cal_month, stat_type_cd) NOT ENFORCED
)  COMMENT= 'Various derived metrics can be calculated on the level of a month and a reporting country. These values are not necessarily in sync with the underlying base events. The table contains separate columns for each domain of statistics values. Depending on the statistics type, one of them is filled.';

