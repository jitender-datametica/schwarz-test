CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_PRODUCT_1(
	prod_sid COMMENT 'The unique identifier (surrogate key) for the product.',
	dwh_valid_from_tmsp COMMENT 'The point in time when this record became valid.',
	dwh_valid_to_tmsp COMMENT 'The point in time when this record was no longer valid.',
	dwh_valid_fg COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	prod_nr COMMENT 'The number which (globally) identifies the product within the organization. (Note that the product number is unique for a certain point in time, but may be re_1-used later on.)',
	prod_name COMMENT 'The (global) name by which the product is marketed.',
	prod_descr COMMENT 'A more detailed (free text) description for the product.',
	prod_creation_dt COMMENT 'The date when product was first listed.',
	prod_type_cd COMMENT 'The code identifying the discriminator for products.',
	prod_type_descr COMMENT 'A textual description for the discriminator for products. (Description in group language, i.e. in German)',
	item_type_cd COMMENT 'The code for the subtype discriminator for items.',
	item_type_descr COMMENT 'A textual description for the subtype discriminator for items. (Description in group language, i.e. in German)',
	prod_buying_status_cd COMMENT 'The code for the buying status_1 for products.',
	prod_buying_status_descr COMMENT 'A textual description for the buying status_1 for products. (Description in group language, i.e. in German)',
	prod_design_status_cd COMMENT 'The code for the design status_1 for products.',
	prod_design_status_descr COMMENT 'A textual description for the design status_1 for products. (Description in group language, i.e. in German)',
	packing_type_cd COMMENT 'The code identifying the way, how a product is packed.',
	packing_type_descr COMMENT 'A textual description for the way how a product is packed in group language, i.e. in German.',
	goods_on_consignment_fg COMMENT 'An indicator showing, if the product is sold on behalf of a third party. Sales_1 revenue is directly transferred to this third party, who in turn, pays a commisson to the vending party.',
	excl_from_vat_calc_fg COMMENT 'An indidcator showing, if the product should be excluded from the VAT calculation.',
	country_specific_prod_fg COMMENT 'An indicator showing, if the product has been defined by only one country_1 organization and is therefore available only in one country. (This does not include products, which are defined globally, but which happen to be sold in only one country.)',
	item_fam_sid COMMENT 'The unique identifier (surrogate key) for the item_1 family to which this product belongs.',
	item_fam_nr COMMENT 'The number by which the related item_1 family is known to business.',
	item_fam_name COMMENT 'The name of the related item_1 family in group language, i.e. in German.',
	sub_item_grp_sid COMMENT 'The unique identifier (surrogate key) for a sub item_1 group to which this product belongs.',
	sub_item_grp_nr COMMENT 'The number by which the related sub item_1 group is known to business.',
	sub_item_grp_name COMMENT 'The name of the related sub item_1 group in group language, i.e. in German.',
	food_fg COMMENT 'An indicator distinguishing food from non-food items.',
	int_item_grp_sid COMMENT 'The unique identifier [surrogate key] for an international item_1 group to which this product belongs',
	int_item_grp_nr COMMENT 'The number by which the related international item_1 group is known to business.',
	int_item_grp_name COMMENT 'The name of the related international item_1 group in group language, i.e. in German.',
	pillar_sid COMMENT 'The unique identifier (surrogate key) for the pillar, to which this product belongs.',
	pillar_nr COMMENT 'The number by which the related pillar is known to business.',
	pillar_name COMMENT 'The name of the related pillar in group language, i.e. in German.',
	main_pillar_sid COMMENT 'The unique identifier (surrogate key) for the top pillar, to which this product belongs.',
	main_pillar_nr COMMENT 'The number by which the related top pillar is known to business.',
	main_pillar_name COMMENT 'The name of the related top pillar in group language, i.e. in German.',
	dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.',
	dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.',
	dwh_load_id COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	dwh_node_cd COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
) COMMENT='The term „Product\" describes goods and services which are offered by the enterprise. In the case of a retailer these are the goods the company trades with. The term “product” is not limited to the current assortment of goods and services, but may also include articles of competitors or articles which are currently not in the assortment.'
 AS SELECT 
   main.prod_sid AS prod_sid
, main.dwh_valid_from_tmsp AS dwh_valid_from_tmsp
, main.dwh_valid_to_tmsp AS dwh_valid_to_tmsp
, main.dwh_valid_fg AS dwh_valid_fg
, main.prod_nr AS prod_nr
, main.prod_name AS prod_name
, main.prod_descr AS prod_descr
, main.prod_creation_dt AS prod_creation_dt
, main.prod_type_cd AS prod_type_cd
, main.prod_type_descr AS prod_type_descr
, main.item_type_cd AS item_type_cd
, main.item_type_descr AS item_type_descr
, main.prod_buying_status_cd AS prod_buying_status_cd
, main.prod_buying_status_descr AS prod_buying_status_descr
, main.prod_design_status_cd AS prod_design_status_cd
, main.prod_design_status_descr AS prod_design_status_descr
, main.packing_type_cd AS packing_type_cd
, main.packing_type_descr AS packing_type_descr
, main.goods_on_consignment_fg AS goods_on_consignment_fg
, main.excl_from_vat_calc_fg AS excl_from_vat_calc_fg
, main.country_specific_prod_fg AS country_specific_prod_fg
, main.item_fam_sid AS item_fam_sid
, main.item_fam_nr AS item_fam_nr
, main.item_fam_name AS item_fam_name
, main.sub_item_grp_sid AS sub_item_grp_sid
, main.sub_item_grp_nr AS sub_item_grp_nr
, main.sub_item_grp_name AS sub_item_grp_name
, main.food_fg AS food_fg
, main.int_item_grp_sid AS int_item_grp_sid
, main.int_item_grp_nr AS int_item_grp_nr
, main.int_item_grp_name AS int_item_grp_name
, main.pillar_sid AS pillar_sid
, main.pillar_nr AS pillar_nr
, main.pillar_name AS pillar_name
, main.main_pillar_sid AS main_pillar_sid
, main.main_pillar_nr AS main_pillar_nr
, main.main_pillar_name AS main_pillar_name
, main.dwh_created_tmsp AS dwh_created_tmsp
, main.dwh_updated_tmsp AS dwh_updated_tmsp
, main.dwh_load_id AS dwh_load_id
, main.dwh_node_cd AS dwh_node_cd
FROM CORE_DIM.T_DIM_PRODUCT_1 main WHERE main.dwh_valid_fg;