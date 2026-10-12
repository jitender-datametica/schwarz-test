CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ARTBEW_MO_SUM_REGALACHSE_2
(
	KJMO,
	ART_ID,
	FBB_NR,
	FACHBODEN_NR,
	FACHBODEN_POS,
	BEWART_ID,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	GP_ID,
	HERST_ID,
	DIFF_NETTO_UMS_KONZ,
	EK_MEP_UMSATZ,
	UMSATZ_MWST_BETRAG,
	UMSATZ_NETTO,
	VK_MENGE,
	LOGKOSTENZUSCHLAG
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
 a.kjmo
,a.art_id
,r.fbb_nr
,r.fachboden_nr
,r.fachboden_pos
,a.bewart_id
,a.mandant_id
,a.wup_id
,a.nb_id
,a.gp_id
,herst_id
,CAST(a.diff_umsatz_netto_konz AS NUMBER(38,5)) * r.kapazitaet_faktor    AS diff_netto_ums_konz
,CAST(a.ek_mep AS NUMBER(38,5)) * r.kapazitaet_faktor                  AS ek_mep_Umsatz
,CAST(a.umsatz_mwst_betrag AS NUMBER(38,5))   * r.kapazitaet_faktor
,CAST(a.umsatz_netto AS NUMBER(38,5)) * r.kapazitaet_faktor
,CAST(a.menge AS NUMBER(38,5)) * r.kapazitaet_faktor
,CAST(a.logkostenzuschlag AS NUMBER(38,5)) * r.kapazitaet_faktor

FROM dbp_view.v_artbew_mo_sum_2 a
INNER JOIN dbp_view.v_regalachse_akt_2 r
ON a.art_id = r.art_id
AND a.mandant_id = r.mandant_id
AND a.wup_id = r.wup_id
AND a.nb_id =r.nb_id
WHERE a.mandant_id = 1
AND r.mandant_id = 1
-- NSR5265060 Erweiterung um aktiv_fg = 1 / sschuecke 06.06.2026
And r.aktiv_fg = 1 ;
