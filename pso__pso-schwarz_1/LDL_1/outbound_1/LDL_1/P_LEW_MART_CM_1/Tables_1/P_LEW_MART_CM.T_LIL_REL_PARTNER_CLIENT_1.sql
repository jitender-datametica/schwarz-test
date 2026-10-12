CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cm.t_lil_rel_partner_client_1 (
partner_name STRING(100) NOT NULL OPTIONS(description='Partner name'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client identifier'),
client_long_desc STRING(128) OPTIONS(description='Client long description in German'),
client_long_desc_en STRING(128) OPTIONS(description='Client long description in English'),
PRIMARY KEY (partner_name, client_id) NOT ENFORCED
) OPTIONS(description='Relational Table for Purchasers - Client, designed for Retail Panel');