CREATE OR REPLACE VIEW dbp_msi_view_log.mv_rundlauf_1
-- 27.11.2020 AP0077403, SPEC0092798, Pawel Staniszewski, Creation of the View 
--02.03.2021, SPEC0091861, AP0073899, dknop, initiale Anlage_1, copy from LIS
AS

(SELECT
--CAST(CSUM(1,1) AS BYTEINT) AS  mandant_id,
10 AS rundlauf_transport_fg,
'Industrieabholung' AS  rundlauf_transport_bez
FROM dbp_view.v_tag_1
WHERE dat BETWEEN CURRENT_DATE -7 AND CURRENT_DATE

UNION
SELECT
--CAST(CSUM(1,1) AS BYTEINT) AS mandant_id,
1 AS rundlauf_transport_fg,
'Rundlauf'  AS rundlauf_transport_bez
FROM dbp_view.v_tag_1
WHERE dat BETWEEN CURRENT_DATE -7 AND CURRENT_DATE

UNION
SELECT
--CAST(CSUM(1,1) AS BYTEINT) AS  mandant_id,
0 AS rundlauf_transport_fg,
'OneWay' AS  rundlauf_transport_bez
FROM dbp_view.v_tag_1
WHERE dat BETWEEN CURRENT_DATE -7 AND CURRENT_DATE
);
