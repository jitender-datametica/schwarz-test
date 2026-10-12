CREATE TABLE IF NOT EXISTS szd_core.t_dim_deposit_item_1 (
item_grp_nr STRING(20) NOT NULL
OPTIONS(description='The number by which the international item_1 group is known to business.'),
deposit_item_name STRING(100) OPTIONS(description='The name by which the deposit item_1 is known.'),
ean_1 STRING(16777216) OPTIONS(description='An European article number'),
deposit_item_cat_cd STRING(16777216)
OPTIONS(description='The category of the deposit item_1 i.e. refillable, non-refillable'),
rvm_manufacturer_sid BIGNUMERIC(38,0),
lob_cd STRING(16777216)
OPTIONS(description='The code for the line of business within the Schwarz Group, i.e.Lidl or Kauflandlob=line os business'),
country_pol_cd STRING(16777216) NOT NULL
OPTIONS(description='The code identifying a political country_1 according to ISO 3166.'),
item_content_cl_qty STRING(16777216) OPTIONS(description='The content of an item_1 in cl'),
item_material_name STRING(100) OPTIONS(description='The material the item_1 is made of'),
item_refund STRING(16777216) OPTIONS(description='The refund amount of an item_1'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (item_grp_nr) NOT ENFORCED
)
OPTIONS(description='Deposit items, i.e. items for which a deposit is charged and which customers are supposed to bring back to the store. E.g. empty bottles.');