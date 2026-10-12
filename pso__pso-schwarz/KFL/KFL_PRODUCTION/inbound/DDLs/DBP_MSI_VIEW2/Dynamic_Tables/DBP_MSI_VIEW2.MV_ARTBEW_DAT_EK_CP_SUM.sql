CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_ARTBEW_DAT_EK_CP_SUM
(
	MANDANT_ID,
	ART_ID,
	GP_ID,
	BEWART_ID,
	BEWART_DET_ID,
	WUP_ID,
	NB_ID,
	DAT,
	WRG_ID,
	WUP_BEREINIGT_FG,
	ZEK_ID,
	EIGENMARKE_FG,
	UMSATZ_NETTO,
	UMSATZ_NETTO_VJ,
	BETRAG_KMEP_KW,
	BETRAG_KMEP_KW_VJ,
	BETRAG_KMEP_WW,
	BETRAG_KMEP_WW_VJ,
	BETRAG_KMEP_KM,
	BETRAG_KMEP_KM_VJ,
	LOGKOSTENZUSCHLAG,
	LOGKOSTENZUSCHLAG_VJ,
	WERBE_ABSCHRIFT_NETTO,
	WERBE_ABSCHRIFT_NETTO_VJ,
	PREIS_ABSCHRIFT_NETTO,
	PREIS_ABSCHRIFT_NETTO_VJ
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
 mandant_id
,art_id
-- AP0281473/SPEC0323868 Erweiterung um Lieferant / prescherad 23.07.2025
,gp_id 
,bewart_id
,bewart_det_id
,wup_id
,nb_id
,dat
,wrg_id
,wup_bereinigt_fg
,zek_id
,eigenmarke_fg
,umsatz_netto
,umsatz_netto_vj
,betrag_kmep_kw
,betrag_kmep_kw_vj
,betrag_kmep_ww
,betrag_kmep_ww_vj
,betrag_kmep_km
,betrag_kmep_km_vj
,logkostenzuschlag
,logkostenzuschlag_vj
,werbe_abschrift_netto
,werbe_abschrift_netto_vj
,preis_abschrift_netto
,preis_abschrift_netto_vj

FROM dbp_data.artbew_dat_ek_cp_sum
WHERE mandant_id = 1
AND wup_bereinigt_fg = 0;