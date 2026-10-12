CREATE OR REPLACE VIEW dbp_msi_view_log.mv_ipn_1
-- 24.01.2022, AP0081637, SPEC0123461, initial based on LIS, dknop
AS
SELECT
 v01.ipn_id
,v01.ipn_bez
,Cast(TRUNCATE(v01.ipn_id) || ' ' || v01.ipn_bez AS CHAR(68)) AS ipn_id_bez
FROM dbp_view.v_ipn_1 v01

-- Artikel_1 ohne IPN_1
UNION
SELECT
 v02.ipn_id
,v02.ipn_bez
,v02.ipn_id_bez
FROM
(
SELECT 0 AS ipn_id
,'keine IPN_1 vorhanden'  AS ipn_bez
,'0 keine IPN_1 vorhanden' AS ipn_id_bez
) v02
;