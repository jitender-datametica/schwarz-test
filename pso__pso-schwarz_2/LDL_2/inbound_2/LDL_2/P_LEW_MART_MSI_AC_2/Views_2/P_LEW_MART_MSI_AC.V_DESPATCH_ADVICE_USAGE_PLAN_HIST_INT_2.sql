CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_DESPATCH_ADVICE_USAGE_PLAN_HIST_INT_2
(
    byr
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
) AS
SELECT
    byr
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
FROM P_LEW_MART_MSI.v_despatch_advice_usage_plan_hist_int_2
;