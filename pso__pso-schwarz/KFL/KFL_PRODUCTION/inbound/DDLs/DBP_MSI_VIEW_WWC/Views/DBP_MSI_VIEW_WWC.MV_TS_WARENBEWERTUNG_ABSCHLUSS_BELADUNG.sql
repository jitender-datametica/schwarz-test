create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_WWC.MV_TS_WARENBEWERTUNG_ABSCHLUSS_BELADUNG(
	MANDANT_ID,
	DAT_AENDERUNG,
	JOB_START_FG
) as
--04.12.2025 SPEC0327163, Neuanlage
--15.01.2026 SPEC0327163, Umbau auf Tagtabelle
SELECT 
v01.Mandant_id,
v02.dat,
v03.job_start_fg
FROM dbp_data.mandant V01
CROSS JOIN (SELECT MAX(Dat) AS dat ,KJMO,akt_kj 
FROM dbp_data.tag
WHERE akt_kj BETWEEN -2 AND 0 
GROUP BY 2,3) V02
LEFT JOIN dbp_msi_data.ts_warenbewertung_abschluss_beladung V03
ON V01.mandant_id=v03.mandant_id
AND V02.dat=V03.dat_aenderung
WHERE V01.Mandant_ID <>1 ;
