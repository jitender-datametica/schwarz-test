CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_dim_local_product_1 (prod_sid
OPTIONS(description='The unique identifier (surrogate key) for the product.'), country_org_sid
OPTIONS(description='The unique identifier (surrogate key) for the country_1 organization.'), country_org_cd
OPTIONS(description='The code of the business country_1 for which this country_1 organization is responsible. (The business country_1 is not identical to a political country.)'),
dwh_valid_from_tmsp OPTIONS(description='The point in time when this record became valid.'), dwh_valid_to_tmsp
OPTIONS(description='The point in time when this record was no longer valid.'), dwh_valid_fg
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
local_prod_nr
OPTIONS(description='The number which identifies the product within the given market / internal organization. (i.e. the local item_1 number)  Note that the product number is unique for a certain point in time, but may be re_1-used later on.'),
alt_1_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the first additional product number.'),
alt_2_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the second additional product number.'),
alt_3_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the third additional product number.'),
alt_4_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the forth additional product number.'),
alt_5_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the fifth additional product number.'),
alt_6_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the sixth additional product number.'),
alt_7_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the seventh additional product number.'),
alt_8_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the eight additional product number.'),
alt_9_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the ninth additional product number.'),
alt_10_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the tenth additional product number.'),
alt_11_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the eleventh additional product number.'),
alt_12_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the twelveth additional product number.'),
alt_13_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the thirteenth additional product number.'),
alt_14_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the forteenth additional product number.'),
alt_15_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the fifteenth additional product number.'),
alt_16_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the sixteenth additional product number.'),
alt_17_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the seventeenth additional product number.'),
alt_18_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the eighteenth additional product number.'),
alt_19_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the nineteenth additional product number.'),
alt_20_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is the twentieth additional product number.'),
alt_local_prod_nr
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. In this case, this is combination of all additional product numbers.'),
alt_local_prod_nr_cnt
OPTIONS(description='A product may be identified by more than one product number within a country_1 organization. This is the total number of additional product numbers that exist in the given country_1 organization. (Note that only the first five product numbers are stored in the columns alt_<n>_local_prod_nr.)'),
local_prod_name
OPTIONS(description='The name by which the product is marketed within the given market / internal organization. (This is the local product name.)'),
local_prod_descr
OPTIONS(description='A more detailed (free text) description for the product - which applies to the given market / internal organization.'),
local_prod_version_nr OPTIONS(description='The version number of the product in the given market / internal company.'),
local_prod_creation_dt
OPTIONS(description='The date when the product was created in the operational system for the given market / internal company.'),
plu_nr
OPTIONS(description='Price Lookup Code; a 4 or 5 digit code to identify items, used mostly for fruits and vegetables.'),
prod_status_cd OPTIONS(description='The code for the status_1 for products, as defined by the retail system.'),
prod_status_descr
OPTIONS(description='A textual description for the status_1 for products, as defined by the retail system. (Description in group language, i.e. in German)'),
brand_type_cd OPTIONS(description='A code that identifies the brand_1 type. (own brand_1 vs. private brand_1)'),
brand_type_descr
OPTIONS(description='A textual description for the brand_1 type (own brand_1 vs. private brand_1) in group language, i.e.in German.'),
brand_name OPTIONS(description='The name of the brand.'), sup_sid
OPTIONS(description='The unique identifier (surrogate key) for the supplier_1 of this product for the given country_1 organization.'),
sup_name OPTIONS(description='The name by which the supplier_1 is known.'), buyer_sid
OPTIONS(description='The unique identifier (surrogate key) for the employee_1, who negotiated this product for the given country_1 organization.'),
buyer_nr OPTIONS(description='The number which identifies the buyer within the organization.'), local_list_dt
OPTIONS(description='The date when the product was first listed in the given market / internal company.'),
local_delist_dt
OPTIONS(description='The date when the product was removed from the assortment in the given market / internal company.'),
intrastat_nr OPTIONS(description='The Intrastat number which identifies a certain class of products.'), intrastat_name
OPTIONS(description='The name for the Intrastat number. This is the eight-digit number. (Name in group language, i.e. in German)'),
locked_fg
OPTIONS(description='An indicator showing, if the product has been locked for the given market / internal company. In that case the product cannot be sold, but may still be returned.'),
vat_refund_fg
OPTIONS(description='An indicator showing, if the product is elegible for VAT refund in the given market.'),
dangerous_goods_fg OPTIONS(description='An indicator for hazardous material.'), country_specific_prod_fg
OPTIONS(description='An indicator showing, if the underlying product has been defined by only one country_1 organization and is therefore available only in one country. (This does not include products, which are defined globally, but which happen to be sold in only one country.) On product variant level this means, that this is the only variant of the product.'),
dispatch_grp_nr
OPTIONS(description='The number which identifies the dispatch group, i.e. the group of products which are handled together in the logistics process.'),
dispatch_grp_descr
OPTIONS(description='A textual description for the dispatch group. (Description in group language, i.e. in German)'),
dispatch_unit_cd
OPTIONS(description='The code identifying the unit_1 of measure by which products get ordered, e.g. by pallet, by layer on a pallet, etc.'),
dispatch_unit_descr
OPTIONS(description='A textual description for the unit_1 of measure by which products get ordered, e.g. by pallet, by layer on a pallet, etc. (Description in group language, i.e. in German)'),
list_type_cd
OPTIONS(description='The code identifying the listing type, e.g. regular assortment, seasonal products, promotional items, etc.'),
list_type_descr
OPTIONS(description='A textual description for the listing type. E.g. regular assortment, seasonal products, promotional items, etc. (Description in group language, i.e. in German)'),
order_area_nr OPTIONS(description='The number which identifies the order area.'), order_area_descr
OPTIONS(description='A textual description for the order area. (Description in group language, i.e. in German)'),
min_cust_age_meas OPTIONS(description='The minimum age for a customer who wants to purchase this product.'), sort_seq
OPTIONS(description='The sort order of the product on lists. The sort order is relative to the item_1 family of the product.'),
min_consumption_day_cnt
OPTIONS(description='The minimum amount of life (in number of days) an item_1 must have remaining when bought by a customer.'),
min_shelflife_to_store_day_cnt
OPTIONS(description='The minimum amount of shelf life (in number of days) an item_1 must have remaining when delivered to a store.'),
min_shelflife_to_wh_day_cnt
OPTIONS(description='The minimum amount of life (in number of days) an item_1 must have remaining when delivered to the warehouse.'),
deliv_temp_meas OPTIONS(description='The (recommended) delivery temperature for the product.'), min_deliv_temp_meas
OPTIONS(description='The minimum delivery temperature for the product.'), max_deliv_temp_meas
OPTIONS(description='The maximum delivery temperature for the product.'), uom_cd
OPTIONS(description='The code identifying the unit_1 of measure.'), shelflife_check_on_receipt_fg
OPTIONS(description='An indicator showing, if the minimum shelflife for this product shall be checked upon receipt.'),
item_fam_sid
OPTIONS(description='The unique identifier (surrogate key) for the item_1 family to which this product belongs.'),
item_fam_nr OPTIONS(description='The number by which the related item_1 family is known to business.'), item_fam_name
OPTIONS(description='The name of the related item_1 family in group language, i.e. in German.'), sub_item_grp_sid
OPTIONS(description='The unique identifier (surrogate key) for a sub item_1 group to which this product belongs.'),
sub_item_grp_nr OPTIONS(description='The number by which the related sub item_1 group is known to business.'),
sub_item_grp_name OPTIONS(description='The name of the related sub item_1 group in group language, i.e. in German.'),
int_item_grp_sid
OPTIONS(description='The unique identifier [surrogate key] for an international item_1 group to which this product belongs.'),
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
OPTIONS(DESCRIPTION = `THIS DIMENSION CONTAINS THE PROPERTIES OF A PRODUCT, AS THEY ARE DEFINED BY A COUNTRY_1 ORGANIZATION.`)
AS SELECT prod_sid,
 country_org_sid,
 country_org_cd,
 dwh_valid_from_tmsp,
 dwh_valid_to_tmsp,
 dwh_valid_fg,
 local_prod_nr,
 alt_1_local_prod_nr,
 alt_2_local_prod_nr,
 alt_3_local_prod_nr,
 alt_4_local_prod_nr,
 alt_5_local_prod_nr,
 alt_6_local_prod_nr,
 alt_7_local_prod_nr,
 alt_8_local_prod_nr,
 alt_9_local_prod_nr,
 alt_10_local_prod_nr,
 alt_11_local_prod_nr,
 alt_12_local_prod_nr,
 alt_13_local_prod_nr,
 alt_14_local_prod_nr,
 alt_15_local_prod_nr,
 alt_16_local_prod_nr,
 alt_17_local_prod_nr,
 alt_18_local_prod_nr,
 alt_19_local_prod_nr,
 alt_20_local_prod_nr,
                                       COALESCE(alt_1_local_prod_nr, '') || CASE
                                        WHEN alt_2_local_prod_nr IS NULL
                                        THEN ''
                                        ELSE '|'
                                        END || COALESCE(alt_2_local_prod_nr, '') || CASE
                                      WHEN alt_3_local_prod_nr IS NULL
                                      THEN ''
                                      ELSE '|'
                                      END || COALESCE(alt_3_local_prod_nr, '') || CASE
                                    WHEN alt_4_local_prod_nr IS NULL
                                    THEN ''
                                    ELSE '|'
                                    END || COALESCE(alt_4_local_prod_nr, '') || CASE
                                  WHEN alt_5_local_prod_nr IS NULL
                                  THEN ''
                                  ELSE '|'
                                  END || COALESCE(alt_5_local_prod_nr, '') || CASE
                                WHEN alt_6_local_prod_nr IS NULL
                                THEN ''
                                ELSE '|'
                                END || COALESCE(alt_6_local_prod_nr, '') || CASE
                              WHEN alt_7_local_prod_nr IS NULL
                              THEN ''
                              ELSE '|'
                              END || COALESCE(alt_7_local_prod_nr, '') || CASE
                            WHEN alt_8_local_prod_nr IS NULL
                            THEN ''
                            ELSE '|'
                            END || COALESCE(alt_8_local_prod_nr, '') || CASE
                          WHEN alt_9_local_prod_nr IS NULL
                          THEN ''
                          ELSE '|'
                          END || COALESCE(alt_9_local_prod_nr, '') || CASE
                        WHEN alt_10_local_prod_nr IS NULL
                        THEN ''
                        ELSE '|'
                        END || COALESCE(alt_10_local_prod_nr, '') || CASE
                      WHEN alt_11_local_prod_nr IS NULL
                      THEN ''
                      ELSE '|'
                      END || COALESCE(alt_11_local_prod_nr, '') || CASE
                    WHEN alt_12_local_prod_nr IS NULL
                    THEN ''
                    ELSE '|'
                    END || COALESCE(alt_12_local_prod_nr, '') || CASE
                  WHEN alt_13_local_prod_nr IS NULL
                  THEN ''
                  ELSE '|'
                  END || COALESCE(alt_13_local_prod_nr, '') || CASE
                WHEN alt_14_local_prod_nr IS NULL
                THEN ''
                ELSE '|'
                END || COALESCE(alt_14_local_prod_nr, '') || CASE
              WHEN alt_15_local_prod_nr IS NULL
              THEN ''
              ELSE '|'
              END || COALESCE(alt_15_local_prod_nr, '') || CASE
            WHEN alt_16_local_prod_nr IS NULL
            THEN ''
            ELSE '|'
            END || COALESCE(alt_16_local_prod_nr, '') || CASE
          WHEN alt_17_local_prod_nr IS NULL
          THEN ''
          ELSE '|'
          END || COALESCE(alt_17_local_prod_nr, '') || CASE
        WHEN alt_18_local_prod_nr IS NULL
        THEN ''
        ELSE '|'
        END || COALESCE(alt_18_local_prod_nr, '') || CASE
      WHEN alt_19_local_prod_nr IS NULL
      THEN ''
      ELSE '|'
      END || COALESCE(alt_19_local_prod_nr, '') || CASE
    WHEN alt_20_local_prod_nr IS NULL
    THEN ''
    ELSE '|'
    END || COALESCE(alt_20_local_prod_nr, '') AS alt_local_prod_nr,
 alt_local_prod_nr_cnt,
 local_prod_name,
 local_prod_descr,
 local_prod_version_nr,
 local_prod_creation_dt,
 plu_nr,
 prod_status_cd,
 prod_status_descr,
 brand_type_cd,
 brand_type_descr,
 brand_name,
 sup_sid,
 sup_name,
 buyer_sid,
 buyer_nr,
 local_list_dt,
 local_delist_dt,
 intrastat_nr,
 intrastat_name,
 locked_fg,
 vat_refund_fg,
 dangerous_goods_fg,
 country_specific_prod_fg,
 dispatch_grp_nr,
 dispatch_grp_descr,
 dispatch_unit_cd,
 dispatch_unit_descr,
 list_type_cd,
 list_type_descr,
 order_area_nr,
 order_area_descr,
 min_cust_age_meas,
 sort_seq,
 min_consumption_day_cnt,
 min_shelflife_to_store_day_cnt,
 min_shelflife_to_wh_day_cnt,
 deliv_temp_meas,
 min_deliv_temp_meas,
 max_deliv_temp_meas,
 uom_cd,
 shelflife_check_on_receipt_fg,
 item_fam_sid,
 item_fam_nr,
 item_fam_name,
 sub_item_grp_sid,
 sub_item_grp_nr,
 sub_item_grp_name,
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
FROM ldl_data_core_dim.t_dim_local_product_1 AS MAIN
WHERE dwh_valid_fg;