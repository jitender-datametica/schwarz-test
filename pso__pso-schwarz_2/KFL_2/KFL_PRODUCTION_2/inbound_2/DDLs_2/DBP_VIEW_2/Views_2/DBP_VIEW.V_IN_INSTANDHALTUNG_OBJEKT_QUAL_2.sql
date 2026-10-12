create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_IN_INSTANDHALTUNG_OBJEKT_QUAL_2(
	MANDANT_ID,
	QUAL_MELDUNG_ID,
	TP_OBJEKT_ID,
	AUFTRAG_ID,
	TECHN_PLATZ_ID,
	DAT_STOER_BEGINN,
	CS_AUFTRAG_PRIO
) as 
    SELECT 
        mandant_id
        ,qual_meldung_id
        ,tp_objekt_id
        ,auftrag_id
        ,techn_platz_id
        ,dat_stoer_beginn
        ,cs_auftrag_prio
FROM DBP_DATA.in_instandhaltung_objekt_qual_2 ;
