CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lagersortiment_2
AS
-- 2020-11-24  nwag2310  moved lagerort_erp to seperate view mv_lagersortiment_lagerort_erp_zu_2 to avoid duplication of report results
-- 02.03.2021, AP0053509, nwag2310, filter on true EWM-LGNUM
-- 20.07.2021, AP0079230, dknop,  added artificaial records for assortment 0 + 9
-- 01.02.2022, dknop, adding v0.wup_id>0
SELECT
v0.mandant_id,
v0.lagernummer_id,
v0.lagersortiment_id,
v0.wup_id,
v0.nb_id
FROM dbp_view.v_l_lagersortiment_2 v0
WHERE LEFT(v0.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' ) AND v0.wup_id>0
GROUP BY
 v0.mandant_id
,v0.lagernummer_id
,v0.lagersortiment_id
,v0.wup_id
,v0.nb_id

UNION ALL

SELECT 
v0.mandant_id,
v0.lagernummer_id,
CASE WHEN v0.lagersortiment_id = 1 THEN '0' WHEN v0.lagersortiment_id =2 THEN '9' END  AS lagersortiment_id,
v0.wup_id,
v0.nb_id
FROM dbp_view.v_l_lagersortiment_2 v0
WHERE LEFT(v0.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' ) AND v0.lagersortiment_id IN ('1','2') AND v0.wup_id>0
GROUP BY  v0.mandant_id
,v0.wup_id
,v0.nb_id
,v0.lagernummer_id
,v0.lagersortiment_id
;