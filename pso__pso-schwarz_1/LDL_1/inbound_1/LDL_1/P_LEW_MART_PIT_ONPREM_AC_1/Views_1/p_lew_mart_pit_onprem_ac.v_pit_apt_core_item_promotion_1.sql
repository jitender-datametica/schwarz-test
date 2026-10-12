CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_APT_CORE_ITEM_PROMOTION_1
AS
SELECT
     client_id
    
, item_sid
    
, promotion_dt
    
, promotion_cy_week
    
, promotion_busyear
    
, promotion_end_dt
    
, promotion_end_dt_created_fg
    
, promotion_end_dt_truncated_fg
    
, promotion_period_orig_days
    
, advertising_campaign
    
, advertising_theme
    
, advertising_group
    
, advertising_sub_group
    
, turnover_plan_val
    
, item_sid_prev_promotion
    
, promotion_time_prev_promotion
    
, sales_price
    
, sales_price_orig
    
, sales_price_comment
    
, promotion_comment
    
, item_list_type
    
, promotion_store_placement_int
    
, promotion_store_placement_nat
    
, promotion_type_int
    
, promotion_type_nat
    
, deleted_fg
    
, excluded_fg
    
, dwh_load_id
    
, dwh_created
    
, dwh_updated
FROM p_lew_mart_pit_onprem.v_pit_apt_core_item_promotion_1;