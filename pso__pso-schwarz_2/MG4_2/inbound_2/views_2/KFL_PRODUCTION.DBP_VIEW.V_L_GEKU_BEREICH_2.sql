create or replace view KFL_PRODUCTION.DBP_VIEW.V_L_GEKU_BEREICH_2(
	GEKU_BEREICH_UID,
	GEKU_BEREICH_ID,
	WMD_FG,
	KDC_FG,
	MZK_FG
) as 
    SELECT 
        geku_bereich_uid
        ,geku_bereich_id
        ,wmd_fg
        ,kdc_fg
        ,mzk_fg


FROM DBP_DATA.l_geku_bereich_2 ;