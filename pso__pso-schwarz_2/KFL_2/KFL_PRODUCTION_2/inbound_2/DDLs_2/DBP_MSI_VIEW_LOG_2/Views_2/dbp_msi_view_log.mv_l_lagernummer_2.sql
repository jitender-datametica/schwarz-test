CREATE OR REPLACE VIEW dbp_msi_view_log.mv_l_lagernummer_2 
-- 03.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
-- 01.12.2025, align with SPR_ZU (wup_id > 0)
AS
SELECT
v01.lagernummer_id,
v01.mandant_id,
v01.nb_id,
v01.wup_id,
v01.oug_fg,
v01.dummy_tor_id,
LEFT(v01.lagernummer_id ,3) AS lagernummer_erp_id
FROM dbp_view.v_l_lagernummer_2 v01
WHERE LEFT(v01.lagernummer_id ,1) IN ( 'D','H','S','P','B','C','M','R' )
AND LENGTH(TRIM(v01.lagernummer_id))=4
AND v01.wup_id > 0;
