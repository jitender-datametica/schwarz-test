
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_ITEM_HIST_LIST_TYPE_1(
     client_id
    ,item_id
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
    ,dur_shelflife_timeunits_wh
    ,dur_shelflife_day_wh
    ,dur_shelflife_timeunits_cust
    ,dur_shelflife_day_cust
    ,dur_shelflife_timeunits_store
    ,dur_shelflife_day_store
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
    ,piece_net_weight
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
    ,listing_type_id
    ,brand_type_id
    ,buying_list_type_group_id
    ,listing_type_group_id
    ,brand_type_group_id
    ,pct_vat
) 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS  
     SELECT 
         itm.client_id
,     itm.item_sid AS item_id
,     CASE WHEN  itm.dat_rec_start < vat.dat_rec_start THEN vat.dat_rec_start ELSE itm.dat_rec_start END AS dat_rec_start
,     CASE WHEN  itm.dat_rec_end > vat.dat_rec_end THEN vat.dat_rec_end ELSE itm.dat_rec_end END AS dat_rec_end
,     itm.dat_valid_from
,     itm.add_docs_fg
,     itm.additions
,     itm.age_fg
,     itm.beverage_tax
,     itm.brand_name
,     itm.buyer_id
,     itm.buyer_name
,     COALESCE(itm.buying_list_type_id, -1) AS buying_list_type_id
,     CASE WHEN itm.buying_list_type_id IS NULL THEN  'Dummy_1-Artikelart' ELSE itm.buying_list_type_desc END AS buying_list_type_desc
,     itm.buying_list_orderset_nr
,     itm.qty_min_piece_ordering
,     itm.buyer_name_int
,     itm.contract_country_cd
,     itm.case_dd
,     itm.case_depth
,     itm.case_euro
,     itm.case_layer
,     itm.case_plu_fg
,     itm.case_height
,     itm.case_size
,     itm.case_size_dec
,     itm.case_volume
,     itm.case_weight
,     itm.case_width
,     itm.commodity_cd
,     itm.cont_deposit_item_nr
,     itm.consumption_tax_main_id
,     itm.consumption_tax_sub_id
,     itm.country_cd
,     itm.dangerous_goods_fg
,     itm.dat_adv
,     itm.dat_delisting
,     itm.dat_listing
,     itm.dat_min_shelflifetest_fg
,     itm.delisting_fg
,     itm.delivery_temp
,     itm.val_deposit
,     itm.direct_delete_mde_fg
,     itm.discount_fg
,     itm.dualsystem_fg
,     itm.dur_shelflife_wh
,     itm.dur_shelflife_cust
,     itm.dur_shelflife_store    
,     CAST(TRUNC(itm.dur_shelflife_wh) AS INTEGER)  AS dur_shelflife_timeunits_wh
,     CASE WHEN itm.period_id_shelflife_wh IN (1,2,3)  THEN (dur_shelflife_timeunits_wh * itm.factor_period_wh)  ELSE dur_shelflife_timeunits_wh  END AS dur_shelflife_day_wh    
,     CAST(TRUNC(itm.dur_shelflife_cust) AS INTEGER)  AS dur_shelflife_timeunits_cust
,     CASE WHEN itm.period_id_shelflife_cust IN (1,2,3)  THEN (dur_shelflife_timeunits_cust * itm.factor_period_cust)  ELSE dur_shelflife_timeunits_cust  END AS dur_shelflife_day_cust  
,     CAST(TRUNC(itm.dur_shelflife_store) AS INTEGER)  AS dur_shelflife_timeunits_store
,     CASE WHEN itm.period_id_shelflife_store IN (1,2,3)  THEN (dur_shelflife_timeunits_store * itm.factor_period_store)  ELSE dur_shelflife_timeunits_store  END AS dur_shelflife_day_store         
,     itm.factor_period_cust
,     itm.factor_period_store
,     itm.factor_period_wh
,     itm.food_fg
,     itm.forwarding_item_nr
,     itm.int_subitemgroup_id
,     itm.item_familygroup_id
,     itm.item_parts
,     itm.item_parts_cd
,     itm.item_plu_nr
,     itm.item_short_desc_1
,     itm.item_short_desc_2
,     itm.item_text_1
,     itm.item_text_2
,     itm.item_text_3
,     itm.item_short_desc_3
,     itm.item_version
,     itm.lidl_buying_country_cd
,     itm.listing_fg
,     itm.logistic_unit_cd
,     itm.max_receive_temp
,     itm.mdessp_fg
,     itm.minus_fg
,     itm.min_case_layer
,     itm.min_case_dd
,     itm.min_case_euro
,     itm.min_case_orderunit
,     itm.min_receive_temp
,     itm.net_piece_weight
,     itm.net_case_weight
,     itm.order_area_cd
,     itm.orig_item_nr_int
,     itm.package_qty
,     itm.packing
,     itm.pct_discount
,     itm.pct_consumption_tax
,     itm.period_id_shelflife_cust
,     itm.period_id_shelflife_store
,     itm.period_id_shelflife_wh
,     itm.piece_depth
,     itm.piece_height
,     itm.piece_width
,     itm.piece_volume
,     itm.piece_weight
,     itm.piece_net_weight_kg_meas  AS piece_net_weight
,     itm.poster_fg
,     itm.price_sign_fg
,     itm.price_strip_fg
,     itm.qty_consumption_tax_add
,     itm.res_selltime
,     itm.reusable_fg
,     itm.scale_fg
,     itm.season_fg
,     itm.smallest_orderunit
,     itm.smallest_unit
,     itm.stock_capacity
,     itm.status_id_hq
,     itm.subitemgroup_id
,     itm.tax_refund_fg
,     itm.taxation
,     itm.type_cd
,     itm.type_receive_temp_fg
,     itm.unitsize
,     itm.val_consumption_tax
,     itm.vat_id
,     itm.wallow_nr
,     itm.weight
,     itm.weight_item_fg
,     itm.write_off
,     itm.wg_fg
,     itm.packagetype_desc
,     COALESCE(itm.item_actiongroup_id, -1) AS item_actiongroup_id
,     COALESCE(itm.item_sub_actiongroup_id, -1) AS item_sub_actiongroup_id
,     COALESCE(reflist.listing_type_id, -1) AS listing_type_id
,     COALESCE(reflist.brand_type_id, -1) AS brand_type_id
,     COALESCE(reflist.buying_list_type_group_id, -1) AS buying_list_type_group_id
,     COALESCE(reflist.listing_type_group_id, -1) AS listing_type_group_id
,     COALESCE(reflist.brand_type_group_id, -1) AS brand_type_group_id
,     vat.pct_vat  
    FROM p_lew_core_ac.v_wawi_itm_item_1  AS itm  
     LEFT OUTER JOIN p_lew_core_ac.v_wawi_ref_itm_list_type_1 AS reflist  
     ON  itm.buying_list_type_id = reflist.buying_list_type_id  
     AND itm.client_id = reflist.language_id  
     LEFT OUTER JOIN  
     (         
SELECT  
         client_id 
        , vat_id  
        , pct_vat 
        , min_date + 1 AS dat_rec_start         
        , CASE   
            WHEN end_date = DATE'2200-01-01' THEN DATE'9999-12-31'  
            ELSE end_date   
         END AS dat_rec_end 
    FROM  
    ( /* Normalize*/
      SELECT 
            t.client_id 
           , t.vat_id 
           , t.pct_vat
           , MIN(t.start_date) ||' , ' ||   MAX(t.end_date) AS validity_1
           , MIN(t.start_date) AS min_date
           , MAX(t.end_date) AS end_date
          FROM ( 
            SELECT T1.*
            , SUM(Flag) OVER (PARTITION BY client_id, vat_id, pct_vat ORDER BY start_date ROWS UNBOUNDED PRECEDING) AS groupid
          FROM 
            (
          SELECT 
                client_id
               , vat_Id
               , pct_vat
               , dat_rec_end AS end_date
               , MIN(dat_rec_start)-1 AS start_date
               , (CASE WHEN dateadd('days',-1,start_date) <= LAG(end_date) OVER (PARTITION BY client_id, vat_id, pct_vat ORDER BY start_date, end_date) THEN 0 ELSE 1 END) AS Flag
               FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 
              GROUP BY client_id, vat_id,pct_vat, end_date
          ) T1_1 
              GROUP BY end_date, client_id, vat_id,pct_vat, Flag, start_date
          ) T
               GROUP BY t.client_id, t.vat_id, t.pct_vat, t.groupid        
      UNION     
      ( 
        SELECT  
        client_id  
        , vat_id  
        , NULL AS pct_vat        
        , (TO_DATE('1900-01-01','YYYY-MM_1-DD')-1) ||' , '|| (MIN(dat_rec_start) -1)  AS validity_1
        , (TO_DATE('1900-01-01','YYYY-MM_1-DD')-1) min_date
        , (MIN(dat_rec_start) -1) end_date   
        FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 
        GROUP BY client_id,vat_id
        HAVING  MIN(dat_rec_start) > DATE'1900-01-01' 
      )    
    ) AS td   
    ) AS vat  
     ON  itm.client_id = vat.client_id  
     AND itm.vat_id = vat.vat_id  
     AND itm.dat_rec_start <= vat.dat_rec_end 
     AND vat.dat_rec_start <= itm.dat_rec_end
     ;
