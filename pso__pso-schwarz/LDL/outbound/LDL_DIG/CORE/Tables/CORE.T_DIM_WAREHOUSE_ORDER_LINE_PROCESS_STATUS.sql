/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_ORDER_LINE_PROCESS_STATUS
   GENERATED FROM POWERDESIGNER ON  2023-05-15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_warehouse_order_line_process_status (
wh_order_line_process_status_cd BIGNUMERIC NOT NULL
OPTIONS(description='The processing status of a certaing Warehouse Order Line in a Wave'),
wh_order_line_process_status_descr STRING(250) NOT NULL
OPTIONS(description='The description of processing status of a certaing Warehouse Order Line in a Wave'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_order_line_process_status_cd) NOT ENFORCED
)
OPTIONS(description='The minor dimension defines warehouse order line  processing statuses in a Wave - documents within a warehouse task process (\'Nicht in Welle\',\'In Welle (nicht freigegeben)\', etc)');