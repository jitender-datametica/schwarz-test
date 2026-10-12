CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lagerauftrag_status_1
-- 18.03.2021, SPEC0105396, AP0080760, dknop, initiale Anlage_1
-- 23.03.2021, SPEC0105396, AP0080760, nwag2310, moved from fact table to pseudo-lookup - to be replaced with /SCWM/DO_WHOSTAT (DD07V)
AS
SELECT
v01.mandant_id,
/*,v01.lagerauftrag_status_id*/
v01.lagernummer_id,
CASE
WHEN v02.akt_tag = -4 THEN ' '
WHEN v02.akt_tag = -3 THEN 'A'
WHEN v02.akt_tag = -2 THEN 'B'
WHEN v02.akt_tag = -1 THEN 'C'
WHEN v02.akt_tag = 0 THEN 'D' END as lagerauftrag_status_id
FROM dbp_view.v_l_lagernummer_1 v01
--only to generate 5 rows!
join
dbp_view.v_tag_1 v02 on v02.akt_tag between -4 and 0
WHERE LEFT(v01.lagernummer_id ,1) in ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(TRIM(v01.lagernummer_id))=4;