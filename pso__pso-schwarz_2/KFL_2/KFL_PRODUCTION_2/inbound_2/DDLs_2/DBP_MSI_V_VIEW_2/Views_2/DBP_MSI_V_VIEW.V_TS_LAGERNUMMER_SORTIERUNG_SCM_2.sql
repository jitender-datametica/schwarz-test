create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_V_VIEW.V_TS_LAGERNUMMER_SORTIERUNG_SCM_2(
	MANDANT_ID COMMENT 'Mandant_2 in DWH.',
	LAGERNUMMER_ID COMMENT 'Lagernummer / Lagerkomplex.',
	WUP_ID COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	NB_ID COMMENT 'Im bisherigen System die 4 Stellen der Marktnummer, die Nebenbetriebskennziffer.',
	LAGERSORTIMENT_ID COMMENT 'Lagersortiment ID.',
	ARTIKELSORTIMENT_ID COMMENT 'Artikelsortiment ID.',
	LAGERNUMMER_SORTIERUNG_SCM_ID COMMENT 'Lagernummersortierung SCM.',
	LAGERNUMMER_SORTIERUNG_SCM_BEZ COMMENT 'Lagernummersortierung SCM (Bezeichnung).',
	DAT_PFLEGE_LAYOUT COMMENT 'Datum, seit dem das Layout eines Verteilzentrums in SAP gepflegt wird. Das Layout wird benötigt um Entfernungen und darauf basierende Kennzahlen auszurechnen. Das Datum wird benötigt um zu verhindern, dass Kennzahlen zu einem Zeitraum gezogen werden, für den es noch kein fertiges / freigegebenes Layout gab.',
	DAT_TMS_WANKO COMMENT 'Golive Datum des WANKO TMS.'
) COMMENT='LIS - Lagernummer Sortierung SCM.'
 as 
    SELECT 
        mandant_id,
        lagernummer_id,
        wup_id,
        nb_id,
        lagersortiment_id,
        artikelsortiment_id,
        lagernummer_sortierung_scm_id,
        lagernummer_sortierung_scm_bez,
        dat_pflege_layout,
        dat_tms_wanko

FROM DBP_MSI_DATA.TS_LAGERNUMMER_SORTIERUNG_SCM_2 ;
