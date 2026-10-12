create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_L_LAGERNUMMER_1(
	MANDANT_ID,
	LAGERNUMMER_ID,
	WUP_ID,
	NB_ID,
	OUG_FG,
	DUMMY_TOR_ID,
	SCU_ID,
	SCU_GUID,
	SORT_ID,
	EWM_FG,
	PERS_TEILBEREICH_ID
) as 
    SELECT 
        mandant_id
        ,lagernummer_id
        ,wup_id
        ,nb_id
        ,oug_fg
        ,dummy_tor_id
        ,scu_id
        ,scu_guid
        ,sort_id
        ,ewm_fg
        ,pers_teilbereich_id

FROM DBP_DATA.l_lagernummer_1;
