CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_RPM_BEDIENKONZEPT_AKT_1 (
	MANDANT_ID,
	WUP_ID,
	BEDIENKONZEPT_ID,
	DAT_BEDIENKONZEPT,
	BEDIENKONZEPT_AUSPR_ID
) AS 

-- 2011.10.12 AL : Initial
-- 2012.10.04 Alex Lipkin :  UNION Gastro DE
-- 2020.01.20 ssch0611 : Update Filter rpm_tab_id=3
-- 2024-07-11 ssch0611 : Review
 
SELECT
  v0.mandant_id
, v0.wup_id
, v01.bedienkonzept_id
, v01.dat_bedienkonzept
, v01.bedienkonzept_auspr_id
FROM dbp_view.v_rpm_immobilie_per_1 v0
 
INNER JOIN dbp_view.v_rpm_hier_bed_konzept_zu_per_1 v01
ON v0.rpm_hierarchie_id = v01.rpm_hierarchie_id
 
-- Nur bestehende Objekte
WHERE v0.dat_bis = '9999-12-31' AND v01.dat_bis = '9999-12-31'
AND v01.rpm_tab_id = 3

UNION ALL /* Gastro Deutschland - aktuell keine */
SELECT
  mandant_id
, wup_id
, 11 AS bedienkonzept_id -- fix für imbiss
, bed_imbiss_dat
, 1 AS bedienkonzept_auspr_id -- imbiss vorhanden 
FROM dbp_msi_v_view.v_wup_denorm_1

WHERE mandant_id = 1 AND bed_imbiss_fg = 1
;