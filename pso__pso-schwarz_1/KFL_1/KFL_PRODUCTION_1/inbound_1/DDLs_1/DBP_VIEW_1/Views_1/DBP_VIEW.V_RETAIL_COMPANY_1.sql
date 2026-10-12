create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_RETAIL_COMPANY_1(
	EXT_SYSTEM_NAME COMMENT 'Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.',
	EXT_RETAIL_COMPANY_ID COMMENT 'ID des Einzelhändlers im externen System.',
	MANDANT_ID COMMENT 'Mandant_1 im DWH.',
	RETAIL_COMPANY_CODE COMMENT 'Code des Einzelhändlers, wie vom Quellsystem bereitgestellt.',
	RETAIL_COMPANY_NAME COMMENT 'Name des Marktes.',
	COMPETITOR_FG COMMENT 'Flag, das angibt, ob es sich um ein Kaufland-Unternehmen (Wert 0) oder einen Mitbewerber (Wert 1) handelt.'
) as 
    SELECT 
        ext_system_name,
        ext_retail_company_id,
        mandant_id,
        retail_company_code,
        retail_company_name,
        competitor_fg

FROM DBP_DATA.RETAIL_COMPANY_1 ;
