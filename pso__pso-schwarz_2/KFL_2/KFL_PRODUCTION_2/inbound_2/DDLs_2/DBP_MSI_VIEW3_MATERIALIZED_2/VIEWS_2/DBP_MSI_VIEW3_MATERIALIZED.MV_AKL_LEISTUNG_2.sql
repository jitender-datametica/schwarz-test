create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_AKL_LEISTUNG_2(
	MANDANT_ID,
	LAGERNUMMER_ID,
	WUP_ID,
	NB_ID,
	DAT,
	STUNDE,
	LAGERTYP_ID,
	MELDEPUNKT,
	WARENBEWEGUNGSTYP_ID,
	LAGER_EINHEITEN_TYP,
	MENGE_LBS_LVS_PALETTE,
	MENGE_LBS_LVS_KOLLI
) as 
SELECT 
 mandant_id
,lagernummer_id
,wup_id
,nb_id
,dat
,stunde
,lagertyp_id
,meldepunkt
,warenbewegungstyp_id
,lager_einheiten_typ
,menge_lbs_lvs_palette
,menge_lbs_lvs_kolli
FROM DBP_VIEW.V_AKL_LEISTUNG_2;