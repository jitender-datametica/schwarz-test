CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lagerort_2 -- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
-- es gibt Lagerorte, z. B. R009 in Möckmühl_2 (6906), die keiner Lagernummer zugeordnet sind
-- 22.01.2021, AP0053509, SPEC0071753, srom0404, Added lagernummer_erp_id 
--10.11.2021, INC3829726, dknop, change to show also lagerort_id -1 (Dummy_2), formatting updates
(
 mandant_id
,wup_id
,nb_id
,lagernummer_id
,lagernummer_erp_id
,lagerort_id
)
AS
SELECT
 v01.mandant_id
,v01.wup_id
,v01.nb_id
,COALESCE(v02.lagernummer_id,'-99') AS lagernummer_id
,LEFT(v01.lagernummer_id ,3) AS lagernummer_erp_id
,lagerort_id
FROM dbp_view.v_l_lagerort_2 v01

LEFT OUTER JOIN dbp_view.v_l_lagernummer_2 v02
ON v01.mandant_id     = v02.mandant_id
AND v01.wup_id         = v02.wup_id
AND v01.nb_id          = v02.nb_id
AND v01.lagernummer_id = v02.lagernummer_id

WHERE v01.lagerort_id NOT IN ('-2', '-3');