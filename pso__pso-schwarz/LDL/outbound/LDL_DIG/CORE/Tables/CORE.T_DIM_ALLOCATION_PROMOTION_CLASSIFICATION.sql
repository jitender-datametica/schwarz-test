CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_allocation_promotion_classification (
alloc_promo_class_cd STRING(5) NOT NULL
OPTIONS(description='The code for the indicating if product is a part of special offer or normal or special assortiment'),
alloc_promo_class_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the product assortiment type in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (alloc_promo_class_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines if product is a part of special offer or normal or special assortment. The allocation classification may not correspond to product classification.');