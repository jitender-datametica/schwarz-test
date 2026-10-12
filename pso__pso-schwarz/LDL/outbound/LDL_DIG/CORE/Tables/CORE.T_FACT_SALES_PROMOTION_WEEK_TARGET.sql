CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_sales_promotion_week_target (
wshop_cd STRING(5) NOT NULL OPTIONS(description='Country of the promotion'),
week_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='For each promotion week, and depending on the promotion duration, there is a planned percentage of units to be sold. '),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
sale_promo_phase_cd STRING(5) NOT NULL
OPTIONS(description='The phase can be either A (Aktion) which corresponds to the first three week of a promotion, or N (Nachlauf) if it is refering to the remaining weeks - after-promotion phase.'),
promo_dur_week_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='How long was the promotion planned to be active (number of weeks)'),
tgt_sale_pct BIGNUMERIC(38,5) OPTIONS(description='Planned percentage of units sold for each promotion week. '),
cum_tgt_sale_pct BIGNUMERIC(38,5)
OPTIONS(description='Cummulative planned percentage of units sold for each promotion week. '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (wshop_cd, week_nr, dwh_valid_from_tmsp, sale_promo_phase_cd, promo_dur_week_cnt) NOT ENFORCED
) OPTIONS(description='A sales target for sales during promotion week by week. ');