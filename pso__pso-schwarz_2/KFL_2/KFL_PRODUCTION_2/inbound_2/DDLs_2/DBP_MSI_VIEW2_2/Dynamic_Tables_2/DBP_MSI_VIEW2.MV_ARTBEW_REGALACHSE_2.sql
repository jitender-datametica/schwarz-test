CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ARTBEW_REGALACHSE_2
(
	ART_ID,
	FBB_NR,
	FACHBODEN_NR,
	FACHBODEN_POS,
	BEWART_ID,
	DAT,
	DIFF_NETTO_UMS_KONZ,
	EK_MEP_UMSATZ,
	GP_ID,
	HERST_ID,
	MANDANT_ID,
	MWST_ID,
	NB_ID,
	UMSATZ_MWST_BETRAG,
	UMSATZ_NETTO,
	VK_MENGE,
	WRG_2,
	WUP_ID,
	BEZUGSWEG_ID,
	AKTION_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
 a.art_id
,fbb_nr
,fachboden_nr
,fachboden_pos
,bewart_id
,dat
,CAST(diff_umsatz_netto_konz AS NUMBER(38,5)) * kapazitaet_faktor    AS diff_netto_ums_konz
,CAST(a.ek_mep AS NUMBER(38,5))  * kapazitaet_faktor                 AS ek_mep_Umsatz
,a.gp_id
,herst_id
,a.mandant_id
,mwst_id
,a.nb_id
,CAST(umsatz_mwst_betrag AS NUMBER(38,5))   * kapazitaet_faktor
,CAST(umsatz_netto AS NUMBER(38,5)) * kapazitaet_faktor
,CAST(menge AS NUMBER(38,5)) * kapazitaet_faktor
,wrg_2
,a.wup_id
,bezugsweg_id
,aktion_id

FROM dbp_view.v_artbew_2 a
INNER JOIN dbp_view.v_regalachse_akt_2 r
ON a.art_id = r.art_id
AND a.mandant_id = r.mandant_id
AND a.wup_id = r.wup_id
AND a.nb_id =r.nb_id

WHERE a.mandant_id = 1 
AND r.mandant_id = 1;