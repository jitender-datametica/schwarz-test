CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_product_1 (prod_sid
OPTIONS(description='The unique identifier (surrogate key) for the product.'), dwh_valid_from_tmsp
OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
prod_nr
OPTIONS(description='The number which (globally) identifies the product within the organization. (Note that the product number is unique for a certain point in time, but may be re_1-used later on.)'),
prod_name OPTIONS(description='The (global) name by which the product is marketed.'), prod_descr
OPTIONS(description='A more detailed (free text) description for the product.'), prod_creation_dt
OPTIONS(description='The date when product was first listed.'), prod_type_cd
OPTIONS(description='The code identifying the discriminator for products.'), prod_type_descr
OPTIONS(description='A textual description for the discriminator for products. (Description in group language, i.e. in German)'),
item_type_cd OPTIONS(description='The code for the subtype discriminator for items.'), item_type_descr
OPTIONS(description='A textual description for the subtype discriminator for items. (Description in group language, i.e. in German)'),
prod_buying_status_cd OPTIONS(description='The code for the buying status_1 for products.'), prod_buying_status_descr
OPTIONS(description='A textual description for the buying status_1 for products. (Description in group language, i.e. in German)'),
prod_design_status_cd OPTIONS(description='The code for the design status_1 for products.'), prod_design_status_descr
OPTIONS(description='A textual description for the design status_1 for products. (Description in group language, i.e. in German)'),
packing_type_cd OPTIONS(description='The code identifying the way, how a product is packed.'), packing_type_descr
OPTIONS(description='A textual description for the way how a product is packed in group language, i.e. in German.'),
goods_on_consignment_fg
OPTIONS(description='An indicator showing, if the product is sold on behalf of a third party. Sales_1 revenue is directly transferred to this third party, who in turn, pays a commisson to the vending party.'),
excl_from_vat_calc_fg
OPTIONS(description='An indidcator showing, if the product should be excluded from the VAT calculation.'),
country_specific_prod_fg
OPTIONS(description='An indicator showing, if the product has been defined by only one country_1 organization and is therefore available only in one country. (This does not include products, which are defined globally, but which happen to be sold in only one country.)'),
item_fam_sid
OPTIONS(description='The unique identifier (surrogate key) for the item_1 family to which this product belongs.'),
item_fam_nr OPTIONS(description='The number by which the related item_1 family is known to business.'), item_fam_name
OPTIONS(description='The name of the related item_1 family in group language, i.e. in German.'), sub_item_grp_sid
OPTIONS(description='The unique identifier (surrogate key) for a sub item_1 group to which this product belongs.'),
sub_item_grp_nr OPTIONS(description='The number by which the related sub item_1 group is known to business.'),
sub_item_grp_name OPTIONS(description='The name of the related sub item_1 group in group language, i.e. in German.'),
food_fg OPTIONS(description='An indicator distinguishing food from non-food items.'), int_item_grp_sid
OPTIONS(description='The unique identifier [surrogate key] for an international item_1 group to which this product belongs'),
int_item_grp_nr OPTIONS(description='The number by which the related international item_1 group is known to business.'),
int_item_grp_name
OPTIONS(description='The name of the related international item_1 group in group language, i.e. in German.'), pillar_sid
OPTIONS(description='The unique identifier (surrogate key) for the pillar, to which this product belongs.'), pillar_nr
OPTIONS(description='The number by which the related pillar is known to business.'), pillar_name
OPTIONS(description='The name of the related pillar in group language, i.e. in German.'), main_pillar_sid
OPTIONS(description='The unique identifier (surrogate key) for the top pillar, to which this product belongs.'),
main_pillar_nr OPTIONS(description='The number by which the related top pillar is known to business.'), main_pillar_name
OPTIONS(description='The name of the related top pillar in group language, i.e. in German.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THE TERM „PRODUCT\\" DESCRIBES GOODS AND SERVICES WHICH ARE OFFERED BY THE ENTERPRISE. IN THE CASE OF A RETAILER THESE ARE THE GOODS THE COMPANY TRADES WITH. THE TERM “PRODUCT” IS NOT LIMITED TO THE CURRENT ASSORTMENT OF GOODS AND SERVICES, BUT MAY ALSO INCLUDE ARTICLES OF COMPETITORS OR ARTICLES WHICH ARE CURRENTLY NOT IN THE ASSORTMENT.`)
AS SELECT prod_sid,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 prod_nr,
 prod_name,
 prod_descr,
 prod_creation_dt,
 prod_type_cd,
 prod_type_descr,
 item_type_cd,
 item_type_descr,
 prod_buying_status_cd,
 prod_buying_status_descr,
 prod_design_status_cd,
 prod_design_status_descr,
 packing_type_cd,
 packing_type_descr,
 goods_on_consignment_fg,
 excl_from_vat_calc_fg,
 country_specific_prod_fg,
 item_fam_sid,
 item_fam_nr,
 item_fam_name,
 sub_item_grp_sid,
 sub_item_grp_nr,
 sub_item_grp_name,
 food_fg,
 int_item_grp_sid,
 int_item_grp_nr,
 int_item_grp_name,
 pillar_sid,
 pillar_nr,
 pillar_name,
 main_pillar_sid,
 main_pillar_nr,
 main_pillar_name,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_core_dim.t_dim_product_1 AS MAIN
WHERE dwh_valid_fg;