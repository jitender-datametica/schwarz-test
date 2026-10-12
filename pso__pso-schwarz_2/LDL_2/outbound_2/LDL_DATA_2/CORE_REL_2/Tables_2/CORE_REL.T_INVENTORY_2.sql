/* --------------------------------------------------------------------------------
   DDL for table: t_inventory_2
   generated from Powerdesigner on Dienstag, 3. Dezember 2024 16:50:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_inventory_2 (
inv_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the inventory event.'),
inv_dt DATE NOT NULL OPTIONS(description='The date when the inventory is carried out.'),
inv_type_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the subtype discriminator for inventorys.'),
inv_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The number which identifies the inventory event in a given country.'),
int_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization for which the inventory is done.'),
int_org_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the discriminators for internal organizations.'),
country_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the related country_2 organization.'),
country_org_cd STRING(2) NOT NULL
OPTIONS(description='The code of the related business country. (The business country_2 is not identical to a political country.)'),
inv_period_start_dt DATE
OPTIONS(description='The inventory period is the business period between last full inventory and the current inventory. This attribute is the start date of this period.'),
inv_period_end_dt DATE
OPTIONS(description='The inventory period is the business period between last full inventory and the current inventory. This attribute is the end date of this period.'),
inv_reason_id BIGNUMERIC(38,0) OPTIONS(description='The identifier for the reason why an inventory was initiated.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (inv_sid) NOT ENFORCED
)
OPTIONS(description='An inventory event is the process of counting the number of products that are on stock in a given store or warehouse (delivery company). The result of an inventory may correct the calculated stock.');