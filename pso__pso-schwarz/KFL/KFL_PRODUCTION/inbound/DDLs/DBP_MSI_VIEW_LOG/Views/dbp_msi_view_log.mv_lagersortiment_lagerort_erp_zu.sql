CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lagersortiment_lagerort_erp_zu
--24.09.2021, dknop, replacing v_l_lagersortiment and v_l_lagerort with lagerort_lagersortiment_zu
--19.10.2021, dknop, formatting updates
AS
SELECT
 v01.mandant_id
,COALESCE(v02.lagerort_id,'-1') AS lagerort_id
,v01.lagersortiment_id
,v01.lagernummer_id
,v01.wup_id
,v01.nb_id
FROM dbp_view.v_l_lagersortiment v01
LEFT JOIN dbp_view.v_lagerort_lagersortiment_zu v02
 ON v01.mandant_id=v02.mandant_id
 AND v01.wup_id=v02.wup_id
 AND v01.lagersortiment_id=v02.lagersortiment_id
WHERE v01.wup_id>0;