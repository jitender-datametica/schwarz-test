CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lagersortiment_prompt 
-- 20201.01.22, AP0063967, SPEC0090556, srom0404, initial
-- 20.07.2021, AP0079230, dknop,  added artificaial records for assortment 0 + 9
AS
SELECT
v0.lagersortiment_id
FROM dbp_view.v_l_lagersortiment v0
GROUP BY
 v0.lagersortiment_id

UNION ALL

SELECT 
CASE WHEN v0.lagersortiment_id = 1 THEN '0' WHEN v0.lagersortiment_id =2 THEN '9' END  AS lagersortiment_id
FROM dbp_view.v_l_lagersortiment v0
where v0.lagersortiment_id in (1,2)
GROUP BY
v0.lagersortiment_id


;