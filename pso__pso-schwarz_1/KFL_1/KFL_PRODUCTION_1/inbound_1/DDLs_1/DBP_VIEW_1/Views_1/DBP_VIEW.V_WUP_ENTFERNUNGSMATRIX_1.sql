create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_WUP_ENTFERNUNGSMATRIX_1(
	WUP_ID_A,
	WUP_ID_B,
	NB_ID_A,
	NB_ID_B,
	MANDANT_ID_A,
	MANDANT_ID_B,
	DISTANZ_FAHRWEG_KM,
	DAUER_FAHRZEIT_MIN,
	MAUT_KM
) as 
    SELECT 
        wup_id_a,
        wup_id_b,
        nb_id_a,
        nb_id_b,
        mandant_id_a,
        mandant_id_b,
        distanz_fahrweg_km,
        dauer_fahrzeit_min,
        maut_km

FROM DBP_DATA.WUP_ENTFERNUNGSMATRIX_1 ;
