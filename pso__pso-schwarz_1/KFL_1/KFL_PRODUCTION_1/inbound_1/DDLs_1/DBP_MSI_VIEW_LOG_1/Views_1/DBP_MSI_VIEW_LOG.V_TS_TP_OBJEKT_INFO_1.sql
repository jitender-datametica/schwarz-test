create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.V_TS_TP_OBJEKT_INFO_1(
	MANDANT_ID,
	TP_OBJEKT_ID,
	TP_OBJEKT_TYP,
	GEBAEUDE_BEZ,
	ANLAGE_BEZ,
	ANLAGENGRUPPE_BEZ,
	ANLAGENTEIL_BEZ
) as 
    SELECT 
        mandant_id
        ,tp_objekt_id
        ,tp_objekt_typ
        ,gebaeude_bez
        ,anlage_bez
        ,anlagengruppe_bez
        ,anlagenteil_bez


FROM DBP_MSI_VIEW_LOG.ts_tp_objekt_info_1 ;
