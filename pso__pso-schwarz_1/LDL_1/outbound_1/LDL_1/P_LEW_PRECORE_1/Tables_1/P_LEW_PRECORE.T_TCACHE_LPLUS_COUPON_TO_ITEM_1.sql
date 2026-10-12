CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_tcache_lplus_coupon_to_item_1 (
l1_insert_time_key DATETIME NOT NULL,
valid_time_key DATETIME NOT NULL,
start_validity_date DATETIME NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
src_country STRING(2),
coupon_sid BIGNUMERIC(38,0) NOT NULL,
src_id STRING(50) NOT NULL,
articles_article_id BIGNUMERIC(38,0),
article_esb_item_id BIGNUMERIC(38,0) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, src_id, article_esb_item_id) NOT ENFORCED
);