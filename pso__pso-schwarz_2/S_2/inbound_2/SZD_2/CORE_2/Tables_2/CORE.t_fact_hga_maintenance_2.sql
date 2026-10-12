/* --------------------------------------------------------------------------------
   DDL for table: t_fact_hga_maintenance_2
   generated from Powerdesigner on Donnerstag, 13. Oktober 2022 15:43:15
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_HGA_MAINTENANCE_2 (
   hga_sid                             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the hot beverage machine which is loacted in a store',
   report_dt                           DATE            NOT NULL COMMENT 'The date on which the report is generated',
   cleaning_liquid_ltr_qty             NUMBER(38, 5)   COMMENT 'The measure of cleaning liquid solution in litre',
   service_cnt                         NUMBER(38, 0)   NOT NULL COMMENT 'The counter of services happened on the machine for a report date',
   filter_cnt                          NUMBER(38, 0)   NOT NULL COMMENT 'The counter of filter on the machine for a report date',
   cleaning_cnt                        NUMBER(38, 0)   NOT NULL COMMENT 'The counter of cleaning done on machine for a report date',
   door_open_cnt                       NUMBER(38, 0)   NOT NULL COMMENT 'The number of times the door has been opened on a report date (derived from the error table based on the error type and status_2)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_FACT_HGA_MAINTENANCE PRIMARY KEY (hga_sid, report_dt) NOT ENFORCED
 )  COMMENT= 'Periodic snapshot_2 fact table storing the measures such as the maintanence and cleaning operation counters of the machine as of the reported date';
