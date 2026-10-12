CREATE OR REPLACE TABLE szd_production_etl.t_cache_owim (
article_number STRING(2000),
article STRING(2000),
customs_tariff_number STRING(2000),
country_of_origin STRING(2000),
allocation STRING(2000),
quantity_in_uom STRING(2000),
tax_code STRING(2000),
import_license_codes STRING(2000),
ea_article_number__according_to_eks___in_case_of_sk STRING(2000),
short_description__single_article__ea_ STRING(2000),
unit_of_measure STRING(2000),
remarks STRING(2000),
export_licence_codes STRING(2000),
additional_export_commodity_codes STRING(2000),
additional_import_commodity_codes STRING(2000),
sdec_suggested_from_supplier STRING(2000),
preferential_origin STRING(2000),
extraction_date DATE,
dwh_created_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(2000),
dwh_src_1_tmsp TIMESTAMP
);