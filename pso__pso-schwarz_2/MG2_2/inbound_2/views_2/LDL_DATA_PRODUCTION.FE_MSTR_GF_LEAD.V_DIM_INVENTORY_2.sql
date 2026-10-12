create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_INVENTORY_2(
	INV_SID COMMENT 'The unique identifier (surrogate key) for the inventory event.',
	INV_DT COMMENT 'The date when the inventory is carried out.',
	INV_TYPE_CD COMMENT 'The code identifying the subtype discriminator for inventories. It distinguishes between full and partial inventories.',
	INV_NR COMMENT 'The number which identifies the inventory event in a given country.',
	INT_ORG_SID COMMENT 'The unique identifier (surrogate key) for the stores for which the inventory is done.',
	INT_ORG_TYPE_CD COMMENT 'The code identifying the discriminators for internal organizations.',
	COUNTRY_ORG_SID COMMENT 'The unique identifier (surrogate key) for the related country_2 organization.',
	COUNTRY_ORG_CD COMMENT 'The code of the related business country. (The business country_2 is not identical to a political country.)',
	INV_PERIOD_START_DT COMMENT 'The inventory period is the business period between last full inventory and the current inventory. This attribute is the start date of this period.',
	INV_PERIOD_END_DT COMMENT 'The inventory period is the business period between last full inventory and the current inventory. This attribute is the end date of this period.',
	INV_REASON_ID COMMENT 'The identifier for the reason why an inventory was initiated.',
	DWH_CREATED_TMSP COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP COMMENT 'The point in time when this record was created or last updated.'
) COMMENT='This fact view contains all inventories in stores (full and part) including period times.'
 as 
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
FROM core_dim.t_dim_inventory_2 -- PK: inv_sid
;