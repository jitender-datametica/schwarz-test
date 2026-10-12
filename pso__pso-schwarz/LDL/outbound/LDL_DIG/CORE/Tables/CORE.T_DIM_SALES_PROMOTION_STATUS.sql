/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_SALES_PROMOTION_STATUS
   GENERATED FROM POWERDESIGNER ON Mittwoch, 22. Juni 2022 14:42:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_sales_promotion_status (
sale_promo_status_cd STRING(25) NOT NULL OPTIONS(description='The unique code for the status of a promotion/delivery.'),
sale_promo_status_descr STRING(250) NOT NULL
OPTIONS(description='The textual description for the status of a promotion/delivery.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (sale_promo_status_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension describes the status of a promotion/delivery');