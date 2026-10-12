CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_transportsortiment_prompt_2
AS
-- 04.03.2021, AP0073899 , nwag2310, initial
-- 16.11.2021, AP0073899, dknop, (transportsortiment_id='-1')
--2022-06-07, AP0125093, SPEC0157732, adding Dummy_2 Records for Transportsortiment ID 99, dknop
SELECT
 v0.mandant_id
,CAST(v0.lagersortiment_id AS VARCHAR(2)) AS transportsortiment_id
FROM dbp_view.v_l_lagersortiment_2 v0
WHERE LEFT(v0.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
AND v0.lagersortiment_id NOT IN ('2','5','7')
GROUP BY
 v0.mandant_id
,v0.lagersortiment_id

UNION
SELECT
 v0.mandant_id
,'27'  AS transportsortiment_id
FROM dbp_view.v_l_lagersortiment_2 v0
WHERE LEFT(v0.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
AND v0.lagersortiment_id='2'
GROUP BY
 v0.mandant_id
 
 UNION
SELECT
 v0.mandant_id
,'-1'  AS transportsortiment_id
FROM dbp_view.v_l_lagersortiment_2 v0
WHERE LEFT(v0.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
AND v0.lagersortiment_id='2'
GROUP BY
 v0.mandant_id
 
   UNION
SELECT
 v0.mandant_id
,'99'  AS transportsortiment_id
FROM dbp_view.v_l_lagersortiment_2 v0
WHERE LEFT(v0.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
AND v0.lagersortiment_id='2'
GROUP BY
 v0.mandant_id;