/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_GOODS_LOSS_ORIGIN_TYPE_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 29. Juni 2022 14:45:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_goods_loss_origin_type_2 (
goods_loss_origin_type_cd STRING(5) NOT NULL
OPTIONS(description='Code identifying the event type that leads to profit or loss ( ex. PC = Price Chagne, CV = coupon validation ...)'),
goods_loss_origin_type_descr STRING(250)
OPTIONS(description='Textual description of the event type that leads to profit or loss'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
PRIMARY KEY (goods_loss_origin_type_cd) NOT ENFORCED
)
OPTIONS(description='A minor dimension that contains type of events that lead to financial profit or loss related to goods (ex  Price Change, Coupon Validation, Scrapping ) ');