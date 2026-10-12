CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_COMPARE_DELV_DEADLINE_1
(
client_id
, per_id
, interface_name
, per_end_date
, status_1
, delivery_content
, delivery_content_smart_desc
, delivery_content_smart_desc_EN
, min_delivery_date
, max_delivery_date
, delivery_count
) AS
SELECT
client_id
, per_id
, interface_name
, per_end_date
, status_1
, delivery_content
, delivery_content_smart_desc
, delivery_content_smart_desc_EN
, min_delivery_date
, max_delivery_date
, delivery_count
FROM P_LEW_MART_CM.V_LIL_COMPARE_DELV_DEADLINE_1;
