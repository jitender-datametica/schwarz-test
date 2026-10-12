CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_pricegrp_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
position_article_sales_rep BIGNUMERIC(38,0) NOT NULL,
pricegroup_id INTEGER NOT NULL,
pricegroup_desc STRING(50) COLLATE 'und:ci' NOT NULL,
article_sales_rep_desc STRING(30) COLLATE 'und:ci' NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);