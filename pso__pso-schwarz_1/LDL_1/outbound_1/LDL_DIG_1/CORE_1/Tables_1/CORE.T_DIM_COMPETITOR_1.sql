/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COMPETITOR_1
   GENERATED FROM POWERDESIGNER ON Montag, 29. Juli 2024 17:13:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_competitor_1 (
competitor_cd STRING(20) NOT NULL OPTIONS(description='The unique code for the Competitor. '),
competitor_group_cd STRING(20) OPTIONS(description='The unqiue code that identifies different Competitor Groups.'),
competitor_name STRING(300) OPTIONS(description='The name of the competitor organization.'),
competitor_group_name STRING(100) OPTIONS(description='The name of the competitor group.'),
competitor_class_name STRING(100)
OPTIONS(description='Classification of the Competitor, based on the characteristics of the competitors e.g. Generalist or Specialist'),
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (competitor_cd) NOT ENFORCED
)
OPTIONS(description='A dimension table that describes the competitors. Competitor is an organization that engages in economic competition with LIDL webshops. e.g Amazon.de, Mediamarkt.de etc.');