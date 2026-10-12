CREATE OR REPLACE TABLE szd_production_etl.t_cache_excise_masterlist_1 (
item_no_short STRING(2000),
single_article_no STRING(2000),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
item_shortdesc STRING(2000),
wg STRING(2000),
volume__in_l_ STRING(2000),
abv_ STRING(2000),
adjusted_abv__wine_only_ STRING(2000),
unit_of_measure__formula_ STRING(2000),
tax_code_ STRING(2000),
duty_per_lpa STRING(2000),
duty_per_unit STRING(2000),
dwh_created_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(2000),
dwh_src_1_tmsp TIMESTAMP
);