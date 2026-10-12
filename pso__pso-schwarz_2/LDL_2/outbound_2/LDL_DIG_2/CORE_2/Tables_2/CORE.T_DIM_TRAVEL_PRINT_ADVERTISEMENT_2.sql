CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_travel_print_advertisement_2 (
trav_print_adv_cd STRING(20) NOT NULL OPTIONS(description='The unique code for print advertisement'),
trav_print_adv_name STRING(100)
OPTIONS(description='The name of print advertisement (e.g. seasonal flyer, theme flyer)'),
trav_print_adv_page_cnt BIGNUMERIC OPTIONS(description='The number of pages in the print advertising'),
trav_print_adv_publish_dt DATE OPTIONS(description='The date when the print advertisement been published'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (trav_print_adv_cd) NOT ENFORCED
) OPTIONS(description='This dimension defines the print advertising details for an offer');