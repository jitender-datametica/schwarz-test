CREATE OR REPLACE VIEW DBP_VIEW.V_NFMD_DISCOUNT_RULE_MATRIX_1 AS 
    SELECT 
        mandant_id
        ,price_class_cd
        ,hwg_id
        ,curve_type_cd
        ,experiment_group_cd
        ,rule_created_dt
        ,sell_wk34_from_wk3_rate_min
        ,sell_wk34_from_wk3_rate_max
        ,wrg_id
        ,suggested_discount_rate
        ,rule_decision_record
        ,rule_status


FROM DBP_DATA.nfmd_discount_rule_matrix_1 ;