/* --------------------------------------------------------------------------------
   DDL for table: t_inventory_statistics_1
   generated from Powerdesigner on Dienstag, 26. November 2024 12:54:00
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INVENTORY_STATISTICS_1 (
   inv_sid                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the inventory event.',
   inv_stat_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of stasticis value that is calculated for an inventory.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   inv_stat_val                        NUMBER(38, 5)   COMMENT 'The calculated statistics measure for the given inventory event, expressed as an amount in the indicated currency.',
   curr_cd                             VARCHAR(3)      COMMENT 'The code identifying the currency, according to ISO 4217.',
   inv_stat_cnt                        NUMBER(38, 0)   COMMENT 'The calculated statistics measure for the given inventory event, expressed as a count.',
   inv_stat_qty                        NUMBER(38, 5)   COMMENT 'The calculated statistics measure for the given inventory event, expressed as a quantity.',
   inv_stat_pct                        NUMBER(38, 5)   COMMENT 'The calculated statistics measure for the given inventory event, expressed as a percentage.',
   inv_stat_meas                       NUMBER(38, 5)   COMMENT 'The calculated statistics measure for the given inventory event, expressed in the indicated unit_1 of measure.',
   uom_cd                              VARCHAR(20)     COMMENT 'The code identifying the unit_1 of measure.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_INVENTORY_STATISTICS PRIMARY KEY (inv_sid, inv_stat_type_cd, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'Various statistics can be calculated as part of the inventory process, such as the total value of the counted products, the related turnover in the inventory period or the inventory difference (i.e. the difference to the calculated stock). The kind of statistics is defined by the statistics type code. The statistics values do not necessarily need to be in sync with the base values.';
