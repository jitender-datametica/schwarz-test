CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_MANAGER_INFO_1
(
    country_iso_cd
    , wh_id
    , store_id
    , sales_manager_id
    , sales_manager_name
    , account_manager_id
    , account_manager_name
    , general_manager_id
    , general_manager_name
)
AS
SELECT
country_iso_cd,
wh_id,
store_id,
sales_manager_id,
sales_manager_name,
account_manager_id,
account_manager_name,
general_manager_id,
general_manager_name
FROM p_lew_mart_wfm.v_manager_info_1
;