CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_IPN_2
-- 26.02.2020, AP0036938, SPEC0068997 - IPM und GTIN fürs_2 WWC, srom: Erweiterung ipn_id, gtin_id
-- 14.12.2023, AP0038599, SPEC0224858 - IPN_2 Dummy_2 mit 0 wurde ergänzt um Join zu Artiklen mit fehlender INP_ID zu ermöglichen
(
 ipn_id
,ipn_bez
,ipn_id_bez
)
AS
SELECT
 v01.ipn_id
,v01.ipn_bez
,Cast(TRUNCATE(v01.ipn_id) || ' ' || v01.ipn_bez AS CHAR(68)) AS ipn_id_bez
FROM  dbp_view.v_ipn_2 v01
UNION 
SELECT
'0',
'keine IPN_2',
'0 keine IPN_2';