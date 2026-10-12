/* 
This view shows all full and part inventories of all stores that have been conducted. It is required for the inventory attribute in Frontend.
*/


CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_dim_inventory_2 (inv_sid
OPTIONS(description='The unique identifier (surrogate key) for the inventory event.'), inv_dt
OPTIONS(description='The date when the inventory is carried out.'), inv_type_cd
OPTIONS(description='The code identifying the subtype discriminator for inventories. It distinguishes between full and partial inventories.'),
inv_nr OPTIONS(description='The number which identifies the inventory event in a given country.'), int_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the stores for which the inventory is done.'),
int_org_type_cd OPTIONS(description='The code identifying the discriminators for internal organizations.'),
country_org_sid OPTIONS(description='The unique identifier (surrogate key) for the related country_2 organization.'),
country_org_cd
OPTIONS(description='The code of the related business country. (The business country_2 is not identical to a political country.)'),
inv_period_start_dt
OPTIONS(description='The inventory period is the business period between last full inventory and the current inventory. This attribute is the start date of this period.'),
inv_period_end_dt
OPTIONS(description='The inventory period is the business period between last full inventory and the current inventory. This attribute is the end date of this period.'),
inv_reason_id OPTIONS(description='The identifier for the reason why an inventory was initiated.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS FACT VIEW CONTAINS ALL INVENTORIES IN STORES (FULL AND PART) INCLUDING PERIOD TIMES.`) AS
SELECT inv_sid,
 inv_dt,
 inv_type_cd,
 inv_nr,
 int_org_sid,
 int_org_type_cd,
 country_org_sid,
 country_org_cd,
 inv_period_start_dt,
 inv_period_end_dt,
 inv_reason_id,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_core_dim.t_dim_inventory_2;