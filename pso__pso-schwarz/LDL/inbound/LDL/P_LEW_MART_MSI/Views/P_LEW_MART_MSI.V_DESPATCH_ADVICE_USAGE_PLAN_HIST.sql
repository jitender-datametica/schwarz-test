CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_DESPATCH_ADVICE_USAGE_PLAN_HIST AS
SELECT
    client_id
    , bus_year AS byr
    , advice_usage_target_rate
    , advice_edi_target_rate
    , advice_avail_edi_target_rate
    , advice_avail_target_rate
    , advice_target_rate
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_load_id
    , dwh_created
    , dwh_updated
    
FROM p_lew_core_ac.v_despatch_advice_usage_plan_hist
WHERE dwh_valid_to = DATE '9999-12-30'
;

