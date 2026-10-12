CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_sales_pieces_per_month_1 (
country_iso_cd STRING(3),
cy_month BIGNUMERIC(38,0),
ian BIGNUMERIC(38,0),
sales_pieces BIGNUMERIC(38,5),
dwh_updated_tmsp DATETIME,
dwh_created_tmsp DATETIME
);