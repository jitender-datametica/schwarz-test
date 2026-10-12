CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_IPN
-- 27.05.2021, srom04040, AP0088365, SPEC0112103 - Neues Attribut IPN
AS
SELECT
 v01.ipn_id
,v01.ipn_bez
,Cast(TRUNCATE(v01.ipn_id) || ' ' || v01.ipn_bez AS CHAR(68)) AS ipn_id_bez
FROM dbp_view.v_ipn v01

-- Artikel ohne IPN
UNION
SELECT
 v02.ipn_id
,v02.ipn_bez
,v02.ipn_id_bez
FROM
(
SELECT 0 AS ipn_id
,'keine IPN vorhanden'  AS ipn_bez
,'0 keine IPN vorhanden' AS ipn_id_bez
) v02
;