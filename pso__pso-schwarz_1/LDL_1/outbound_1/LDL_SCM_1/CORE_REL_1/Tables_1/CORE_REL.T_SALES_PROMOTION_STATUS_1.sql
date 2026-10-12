CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_sales_promotion_status_1 (
sales_promo_status_cd STRING(50) NOT NULL OPTIONS(description='The unique code for the status_1 of a promotion.'),
sales_promo_status_descr STRING(250) NOT NULL
OPTIONS(description='The textual description for the status_1 of a promotion.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (sales_promo_status_cd) NOT ENFORCED
) OPTIONS(description='The entity that describes the status_1 of a promotion.');