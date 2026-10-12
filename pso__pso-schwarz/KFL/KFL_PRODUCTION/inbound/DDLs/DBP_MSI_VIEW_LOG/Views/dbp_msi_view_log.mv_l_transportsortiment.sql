CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_transportsortiment
AS
-- 04.03.2021, AP0073899 , nwag2310, initial
-- 22,03,2021, AP0073899 , nwag2310, removed assortment 5 (goes into 1)
-- 16.11.2021, AP0073899, dknop, (transportsortiment_id='-1')
-- 01.02.2022, dknop, adding v0.wup_id>0
-- 2022-06-07, AP0125093, SPEC0157732, adding Dummy Records for Transportsortiment ID 99, dknop
SELECT
 v0.mandant_id
,CAST(v0.lagersortiment_id AS VARCHAR(2)) AS transportsortiment_id
,v0.lagernummer_id
,v0.wup_id
,v0.nb_id
FROM dbp_view.v_l_lagersortiment v0
WHERE LEFT(v0.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
AND v0.lagersortiment_id NOT IN ('2','5','7')
AND v0.wup_id>0
GROUP BY
 v0.mandant_id
,v0.lagernummer_id
,v0.lagersortiment_id
,v0.wup_id
,v0.nb_id

UNION
SELECT
 v0.mandant_id
,'27'  AS transportsortiment_id
,v0.lagernummer_id
,v0.wup_id
,v0.nb_id
FROM dbp_view.v_l_lagersortiment v0
WHERE LEFT(v0.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
AND v0.lagersortiment_id='2'
AND v0.wup_id>0
GROUP BY
  v0.mandant_id
,v0.lagernummer_id
,v0.lagersortiment_id
,v0.wup_id
,v0.nb_id

UNION
SELECT
 v0.mandant_id
,'-1'  AS transportsortiment_id
,v0.lagernummer_id
,v0.wup_id
,v0.nb_id
FROM dbp_view.v_l_lagersortiment v0
WHERE LEFT(v0.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
AND v0.lagersortiment_id='2'
AND v0.wup_id>0
GROUP BY
  v0.mandant_id
,v0.lagernummer_id
,v0.lagersortiment_id
,v0.wup_id
,v0.nb_id

UNION
SELECT
 v0.mandant_id
,'99'  AS transportsortiment_id
,v0.lagernummer_id
,v0.wup_id
,v0.nb_id
FROM dbp_view.v_l_lagersortiment v0
WHERE LEFT(v0.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
AND v0.lagersortiment_id='2'
AND v0.wup_id>0
GROUP BY
  v0.mandant_id
,v0.lagernummer_id
,v0.lagersortiment_id
,v0.wup_id
,v0.nb_id
;