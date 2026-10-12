create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_L_FREIGABE_1(
	FREIGABE,
	FREIGABE_BEZ
) as
-- 31.08.2018 twie: SPEC0042079 Lookuptabelle für Selektion im RFI Transaction Service Bericht
-- 17.11.2025 twie: SPEC0333810 von materialized view auf normale view umgestellt, dynamic table macht ohne Quelltabelle keinen Sinn

SELECT t.*
       FROM (SELECT * FROM (SELECT 'update' AS freigabe,
       'Ändern ' AS freigabe_bez) x
UNION ALL
SELECT * FROM  (SELECT 'delete' AS freigabe,
       'Löschen' AS freigabe_bez) x
) t
;
