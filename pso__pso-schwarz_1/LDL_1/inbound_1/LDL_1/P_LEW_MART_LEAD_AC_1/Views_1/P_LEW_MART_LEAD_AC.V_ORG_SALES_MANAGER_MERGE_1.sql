CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ORG_SALES_MANAGER_MERGE_1
(
    aspect_id
    , client_id
    , wh_id
    , wh_id_exp
    , loc_sid_wh
    , sales_manager_id
    , account_manager_id
    , sales_manager_name
)
AS
SELECT
aspect_id,
client_id,
wh_id,
wh_id_exp,
loc_sid_wh,
sales_manager_id,
account_manager_id,
sales_manager_name
FROM p_lew_mart_lead.v_org_sales_manager_merge_1
;



