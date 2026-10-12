/* --------------------------------------------------------------------------------
   DDL for table: t_warehouse_work_break_1
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 16:08:14
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_warehouse_work_break_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
work_package_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate identifier to be created (client, warehouse and warehouse work package_1 (WHO)).'),
work_break_seq BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='For each break during work package_1 work (Client+LGNUM+WHO per record) the sequence of breaks is stored (gets generated on data input).'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION_1'),
work_break_start_dt DATE OPTIONS(description='Date when the break was started.'),
work_break_start_tmsp DATETIME OPTIONS(description='The point in time when the break was started.'),
work_break_end_dt DATE OPTIONS(description='Date when the break was ended.'),
work_break_end_tmsp DATETIME OPTIONS(description='The point in time when the break was ended.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (work_break_seq, work_package_sid) NOT ENFORCED
) OPTIONS(description='The table holds the break time for warehouse work package.');