CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WAREHOUSE_WORK_BREAK_1 (
   client_id                                COMMENT 'DWH-Mandant_1; FK auf CLIENT'
  ,work_package_sid                         COMMENT 'Surrogate identifier to be created (client, warehouse and warehouse work package_1 (WHO)).'
  ,work_break_seq                           COMMENT 'For each break during work package_1 work (Client+LGNUM+WHO per record) the sequence of breaks is stored (gets generated on data input).'
  ,wh_loc_sid                               COMMENT 'Warehouse; FK auf LOCATION_1'
  ,work_break_start_dt                      COMMENT 'Date when the break was started.'
  ,work_break_start_tmsp                    COMMENT 'The point in time when the break was started.'
  ,work_break_end_dt                        COMMENT 'Date when the break was ended.'
  ,work_break_end_tmsp                      COMMENT 'The point in time when the break was ended.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'The table holds the break time for warehouse work package.'
AS SELECT
   client_id
  ,work_package_sid
  ,work_break_seq
  ,wh_loc_sid
  ,work_break_start_dt
  ,work_break_start_tmsp
  ,work_break_end_dt
  ,work_break_end_tmsp
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_WAREHOUSE_WORK_BREAK_1;