CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_distribution_zone (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country'),
dist_zone_cd STRING(5) NOT NULL OPTIONS(description='The unique code for a distribution zone ( f.e. BAL , CAN, etc)'),
dist_zone_name STRING(250) NOT NULL
OPTIONS(description='The name for a distribution zone  ( f.e.\'Balearic Islands\' etc)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wshop_cd, dist_zone_cd) NOT ENFORCED
)
OPTIONS(description='A distribution zone is a division within the Lidl Webshop, typically used when territories are separated from a mainland. A Webshop can have one or more distribution zones, defined according to official administrative divisions within each country. These different distribution zones may have variations in assortment, promotion dates, campaigns, pricing for end customers (due to VAT differences), tax information, shipping costs, delivery times, and additional services.');