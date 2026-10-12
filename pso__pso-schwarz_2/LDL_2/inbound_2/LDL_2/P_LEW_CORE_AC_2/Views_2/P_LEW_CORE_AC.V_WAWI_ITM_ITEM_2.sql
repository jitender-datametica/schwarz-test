CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WAWI_ITM_ITEM_2 (
   client_id                                COMMENT ''
  ,item_sid                                 COMMENT ''
  ,dat_rec_start                            COMMENT ''
  ,dat_rec_end                              COMMENT ''
  ,dat_valid_from                           COMMENT ''
  ,add_docs_fg                              COMMENT ''
  ,additions                                COMMENT ''
  ,age_fg                                   COMMENT ''
  ,beverage_tax                             COMMENT ''
  ,brand_name                               COMMENT ''
  ,buyer_id                                 COMMENT ''
  ,buyer_name                               COMMENT ''
  ,buying_list_type_id                      COMMENT ''
  ,buying_list_type_desc                    COMMENT ''
  ,buying_list_orderset_nr                  COMMENT ''
  ,qty_min_piece_ordering                   COMMENT ''
  ,buyer_name_int                           COMMENT ''
  ,contract_country_cd                      COMMENT ''
  ,case_dd                                  COMMENT ''
  ,case_depth                               COMMENT ''
  ,case_euro                                COMMENT ''
  ,case_layer                               COMMENT ''
  ,case_plu_fg                              COMMENT ''
  ,case_height                              COMMENT ''
  ,case_size                                COMMENT ''
  ,case_size_dec                            COMMENT ''
  ,case_volume                              COMMENT ''
  ,case_weight                              COMMENT ''
  ,case_width                               COMMENT ''
  ,commodity_cd                             COMMENT ''
  ,cont_deposit_item_nr                     COMMENT ''
  ,consumption_tax_main_id                  COMMENT ''
  ,consumption_tax_sub_id                   COMMENT ''
  ,country_cd                               COMMENT ''
  ,dangerous_goods_fg                       COMMENT ''
  ,dat_adv                                  COMMENT ''
  ,dat_delisting                            COMMENT ''
  ,dat_listing                              COMMENT ''
  ,dat_min_shelflifetest_fg                 COMMENT ''
  ,delisting_fg                             COMMENT ''
  ,delivery_temp                            COMMENT ''
  ,val_deposit                              COMMENT ''
  ,direct_delete_mde_fg                     COMMENT ''
  ,discount_fg                              COMMENT ''
  ,dualsystem_fg                            COMMENT ''
  ,dur_shelflife_wh                         COMMENT ''
  ,dur_shelflife_cust                       COMMENT ''
  ,dur_shelflife_store                      COMMENT ''
  ,factor_period_cust                       COMMENT ''
  ,factor_period_store                      COMMENT ''
  ,factor_period_wh                         COMMENT ''
  ,food_fg                                  COMMENT ''
  ,forwarding_item_nr                       COMMENT ''
  ,int_subitemgroup_id                      COMMENT ''
  ,item_familygroup_id                      COMMENT ''
  ,item_parts                               COMMENT ''
  ,item_parts_cd                            COMMENT ''
  ,item_plu_nr                              COMMENT ''
  ,item_short_desc_1                        COMMENT ''
  ,item_short_desc_2                        COMMENT ''
  ,item_text_1                              COMMENT ''
  ,item_text_2                              COMMENT ''
  ,item_text_3                              COMMENT ''
  ,item_short_desc_3                        COMMENT ''
  ,item_version                             COMMENT ''
  ,lidl_buying_country_cd                   COMMENT ''
  ,listing_fg                               COMMENT ''
  ,logistic_unit_cd                         COMMENT ''
  ,max_receive_temp                         COMMENT ''
  ,mdessp_fg                                COMMENT ''
  ,minus_fg                                 COMMENT ''
  ,min_case_layer                           COMMENT ''
  ,min_case_dd                              COMMENT ''
  ,min_case_euro                            COMMENT ''
  ,min_case_orderunit                       COMMENT ''
  ,min_receive_temp                         COMMENT ''
  ,net_piece_weight                         COMMENT ''
  ,net_case_weight                          COMMENT ''
  ,order_area_cd                            COMMENT ''
  ,orig_item_nr_int                         COMMENT ''
  ,package_qty                              COMMENT ''
  ,packing                                  COMMENT ''
  ,pct_discount                             COMMENT ''
  ,pct_consumption_tax                      COMMENT ''
  ,period_id_shelflife_cust                 COMMENT ''
  ,period_id_shelflife_store                COMMENT ''
  ,period_id_shelflife_wh                   COMMENT ''
  ,piece_depth                              COMMENT ''
  ,piece_height                             COMMENT ''
  ,piece_width                              COMMENT ''
  ,piece_volume                             COMMENT ''
  ,piece_weight                             COMMENT ''
  ,piece_net_weight_kg_meas                 COMMENT 'Net weight of the item_2 piece, the weight of the contents excluding the packaging, souce system: WAWI, source table: ARTIKELBESTELL_2, source column: FILLING_QTY'
  ,poster_fg                                COMMENT ''
  ,price_sign_fg                            COMMENT ''
  ,price_strip_fg                           COMMENT ''
  ,qty_consumption_tax_add                  COMMENT ''
  ,res_selltime                             COMMENT ''
  ,reusable_fg                              COMMENT ''
  ,scale_fg                                 COMMENT ''
  ,season_fg                                COMMENT ''
  ,smallest_orderunit                       COMMENT ''
  ,smallest_unit                            COMMENT ''
  ,stock_capacity                           COMMENT ''
  ,status_id_hq                             COMMENT ''
  ,subitemgroup_id                          COMMENT ''
  ,tax_refund_fg                            COMMENT ''
  ,taxation                                 COMMENT ''
  ,type_cd                                  COMMENT ''
  ,type_receive_temp_fg                     COMMENT ''
  ,unitsize                                 COMMENT ''
  ,val_consumption_tax                      COMMENT ''
  ,vat_id                                   COMMENT ''
  ,wallow_nr                                COMMENT ''
  ,weight                                   COMMENT ''
  ,weight_item_fg                           COMMENT ''
  ,write_off                                COMMENT ''
  ,wg_fg                                    COMMENT ''
  ,packagetype_desc                         COMMENT ''
  ,item_actiongroup_id                      COMMENT ''
  ,item_sub_actiongroup_id                  COMMENT ''
  ,store_freshness_check_fg                 COMMENT ''
  ,load_id                                  COMMENT ''
)
COMMENT = '2Do:
table comment
PK'
AS SELECT
   client_id
  ,item_sid
  ,dat_rec_start
  ,dat_rec_end
  ,dat_valid_from
  ,add_docs_fg
  ,additions
  ,age_fg
  ,beverage_tax
  ,brand_name
  ,buyer_id
  ,buyer_name
  ,buying_list_type_id
  ,buying_list_type_desc
  ,buying_list_orderset_nr
  ,qty_min_piece_ordering
  ,buyer_name_int
  ,contract_country_cd
  ,case_dd
  ,case_depth
  ,case_euro
  ,case_layer
  ,case_plu_fg
  ,case_height
  ,case_size
  ,case_size_dec
  ,case_volume
  ,case_weight
  ,case_width
  ,commodity_cd
  ,cont_deposit_item_nr
  ,consumption_tax_main_id
  ,consumption_tax_sub_id
  ,country_cd
  ,dangerous_goods_fg
  ,dat_adv
  ,dat_delisting
  ,dat_listing
  ,dat_min_shelflifetest_fg
  ,delisting_fg
  ,delivery_temp
  ,val_deposit
  ,direct_delete_mde_fg
  ,discount_fg
  ,dualsystem_fg
  ,dur_shelflife_wh
  ,dur_shelflife_cust
  ,dur_shelflife_store
  ,factor_period_cust
  ,factor_period_store
  ,factor_period_wh
  ,food_fg
  ,forwarding_item_nr
  ,int_subitemgroup_id
  ,item_familygroup_id
  ,item_parts
  ,item_parts_cd
  ,item_plu_nr
  ,item_short_desc_1
  ,item_short_desc_2
  ,item_text_1
  ,item_text_2
  ,item_text_3
  ,item_short_desc_3
  ,item_version
  ,lidl_buying_country_cd
  ,listing_fg
  ,logistic_unit_cd
  ,max_receive_temp
  ,mdessp_fg
  ,minus_fg
  ,min_case_layer
  ,min_case_dd
  ,min_case_euro
  ,min_case_orderunit
  ,min_receive_temp
  ,net_piece_weight
  ,net_case_weight
  ,order_area_cd
  ,orig_item_nr_int
  ,package_qty
  ,packing
  ,pct_discount
  ,pct_consumption_tax
  ,period_id_shelflife_cust
  ,period_id_shelflife_store
  ,period_id_shelflife_wh
  ,piece_depth
  ,piece_height
  ,piece_width
  ,piece_volume
  ,piece_weight
  ,piece_net_weight_kg_meas
  ,poster_fg
  ,price_sign_fg
  ,price_strip_fg
  ,qty_consumption_tax_add
  ,res_selltime
  ,reusable_fg
  ,scale_fg
  ,season_fg
  ,smallest_orderunit
  ,smallest_unit
  ,stock_capacity
  ,status_id_hq
  ,subitemgroup_id
  ,tax_refund_fg
  ,taxation
  ,type_cd
  ,type_receive_temp_fg
  ,unitsize
  ,val_consumption_tax
  ,vat_id
  ,wallow_nr
  ,weight
  ,weight_item_fg
  ,write_off
  ,wg_fg
  ,packagetype_desc
  ,item_actiongroup_id
  ,item_sub_actiongroup_id
  ,store_freshness_check_fg
  ,load_id
FROM P_LEW_CORE.T_WAWI_ITM_ITEM_2
;