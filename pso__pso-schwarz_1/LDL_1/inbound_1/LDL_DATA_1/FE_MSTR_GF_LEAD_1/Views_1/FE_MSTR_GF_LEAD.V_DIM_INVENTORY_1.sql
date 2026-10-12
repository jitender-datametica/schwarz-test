/* 
This view shows all full and part inventories of all stores that have been conducted. It is required for the inventory attribute in Frontend.
*/
CREATE OR REPLACE VIEW fe_mstr_gf_lead.v_dim_inventory_1 (
	inv_sid COMMENT 'The unique identifier (surrogate key) for the inventory event.',
	inv_dt COMMENT 'The date when the inventory is carried out.',
	inv_type_cd COMMENT 'The code identifying the subtype discriminator for inventories. It distinguishes between full and partial inventories.',
	inv_nr COMMENT 'The number which identifies the inventory event in a given country.',
	int_org_sid COMMENT 'The unique identifier (surrogate key) for the stores for which the inventory is done.',
	int_org_type_cd COMMENT 'The code identifying the discriminators for internal organizations.',
	country_org_sid COMMENT 'The unique identifier (surrogate key) for the related country_1 organization.',
	country_org_cd COMMENT 'The code of the related business country. (The business country_1 is not identical to a political country.)',
	inv_period_start_dt COMMENT 'The inventory period is the business period between last full inventory and the current inventory. This attribute is the start date of this period.',
	inv_period_end_dt COMMENT 'The inventory period is the business period between last full inventory and the current inventory. This attribute is the end date of this period.',
	inv_reason_id COMMENT 'The identifier for the reason why an inventory was initiated.',
	dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.',
	dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
	--dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	--dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
	) COMMENT = 'This fact view contains all inventories in stores (full and part) including period times.'
AS 
SELECT 
	inv_sid
	, inv_dt
	, inv_type_cd
	, inv_nr
	, int_org_sid
	, int_org_type_cd
	, country_org_sid
	, country_org_cd
	, inv_period_start_dt
	, inv_period_end_dt
	, inv_reason_id
	, dwh_created_tmsp
	, dwh_updated_tmsp
	--, dwh_load_id
	--, dwh_node_cd
FROM core_dim.t_dim_inventory_1 -- PK: inv_sid
;
