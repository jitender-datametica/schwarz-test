create or replace view KFL_PRODUCTION.DBP_VIEW.V_IVS_PLAN_2(
	PLANDETAIL_ID,
	MANDANT_ID,
	PLANTYP_ID,
	PLAN_OBJEKT_ID,
	KJMO,
	PLAN_WERT,
	PLAN_WERT_KONZ,
	KOSTENSTELLE_ID,
	DAT_EXTRAKT,
	WRG_ID
) as 
    SELECT 
        plandetail_id
        ,mandant_id
        ,plantyp_id
        ,plan_objekt_id
        ,kjmo
        ,plan_wert
        ,plan_wert_konz
        ,kostenstelle_id
        ,dat_extrakt
        ,wrg_id


FROM DBP_DATA.ivs_plan_2 ;