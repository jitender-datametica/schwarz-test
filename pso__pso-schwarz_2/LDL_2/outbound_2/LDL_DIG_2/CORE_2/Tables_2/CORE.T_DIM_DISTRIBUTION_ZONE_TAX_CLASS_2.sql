/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_DISTRIBUTION_ZONE_TAX_CLASS_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 15. Juli 2025 11:06:51
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_distribution_zone_tax_class_2 (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2'),
dist_zone_cd STRING(5) NOT NULL OPTIONS(description='The unique code for a distribution zone ( f.e. BAL , CAN, etc)'),
tax_class_cd STRING(5) NOT NULL OPTIONS(description='The code identifying the tax class'),
active_from_dt DATE NOT NULL
OPTIONS(description='The first date when this record became valid from a business perspective in the real world (not to be confused with technical validity_2 date - when record is inserted in some system)'),
active_to_dt DATE NOT NULL
OPTIONS(description='The last date until this record was valid from a business perspective in the real world (not to be confused with technical validity_2 date - when record expired in some system)'),
active_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record from a business perspective, i.e. where the current date is between active_from_dt and active_to_dt'),
tax_class_pct BIGNUMERIC(38,5) NOT NULL OPTIONS(description='The tax percentage for the tax class.'),
country_cd STRING(5)
OPTIONS(description='The unique code for a country_2 according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (tax_class_cd, wshop_cd, dist_zone_cd, active_from_dt) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines tax classes for distribution zones. A distribution zone is a division within the Lidl Webshop, typically used when territories are separated from a mainland e,g CAN = Canary Islands, BLR = Balearic Islands etc.. A Webshop can have one or more distribution zones, defined according to official administrative divisions within each country. These different distribution zones may have variations in assortment, promotion dates, campaigns, pricing for end customers (due to VAT differences), tax information, shipping costs, delivery times, and additional services.');