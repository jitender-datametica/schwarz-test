CREATE OR REPLACE TABLE szd_production_core.t_dim_free_trade_agreement_1 (
agreement_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) of the free trade agreement.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
import_country_location_sid INTEGER NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique identifier (surrogate key) of the political country_1 that import goods.'),
import_iso_country_cd STRING(50) NOT NULL
OPTIONS(description='Denormalized Attribute - The ISO code of the political country_1 that import goods.'),
import_country_name_de STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The german name of the political country_1 that import goods.'),
import_country_name_en STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The english name of the political country_1 that import goods.'),
origin_country_location_sid INTEGER NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique identifier (surrogate key) of the political country_1 where the goods comes from.'),
origin_iso_country_cd STRING(50) NOT NULL
OPTIONS(description='Denormalized Attribute - The ISO code of the political country_1 where the goods comes from.'),
origin_country_name_de STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The german name of the political country_1 where the goods comes from.'),
origin_country_name_en STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - The german name of the political country_1 where the goods comes from.'),
free_trade_agreement_category_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the category of a free trade agreement.'),
free_trade_agreement_category_name STRING(50) NOT NULL OPTIONS(description='The name of the category.'),
free_trade_agreement_category_descr STRING(250) NOT NULL
OPTIONS(description='A brief description of the free trade agreement category.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (agreement_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - Contains free trade agreements between the country_1 that import goods and the country_1 where products are imported from. - Source - Manual');