create or replace view KFL_PRODUCTION.DBP_SPEZIAL.V_ODS_TALON_DET_UNION_1(
	MANDANT_ID,
	TALON_ID,
	TALON_POS_ID,
	WUP_ID,
	KL_ART_ID,
	UMSATZ_BRUTTO,
	MENGE,
	MWST,
	WG_ID,
	TURNOVER_FG,
	ARTBEW_FG,
	AKTION_ID
) as 
SELECT mandant_id
,talon_id
,talon_pos_id
,wup_id
,kl_art_id
,umsatz_brutto
,menge
,mwst
,wg_id
,turnover_fg
,artbew_fg
,aktion_id
FROM dbp_ods.ods_talon_det_1
UNION ALL
SELECT mandant_id
,talon_id
,talon_pos_id
,wup_id
,kl_art_id
,umsatz_brutto
,menge
,mwst
,wg_id
,turnover_fg
,artbew_fg
,aktion_id
FROM dbp_ods_archiv.ods_talon_det_1
;