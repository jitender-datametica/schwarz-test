CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_WUP_ART_GP_KORREKTUR_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	DAT_VON,
	DAT_BIS,
	DAT_KORREKTUR,
	DAT_ZURUECKLIEGEND,
	GP_ALT_ID,
	GP_NEU_ID,
	BQ_FINDUNG_ALT_ID,
	BQ_FINDUNG_NEU_ID,
	MENGE_VK_BME,
	BETRAG_UMSATZ_NETTO,
	BETRAG_EK_NETTO_ALT,
	BETRAG_EK_NETTO_NEU,
	BETRAG_EK_MEP_ALT,
	BETRAG_EK_MEP_NEU
) AS SELECT
    v01.mandant_id,
    v01.wup_id,
    v01.nb_id,
    v01.art_id,
    MIN(v01.dat_vk) AS dat_von,
    MAX(v01.dat_vk) AS dat_bis,
    v01.dat_korrektur,
    DATEDIFF(DAY, dat_korrektur, (SELECT MAX(dat_korrektur) FROM dbp_view.v_wup_art_gp_korrektur_1)) AS dat_zurueckliegend,
    v01.gp_alt_id,
    v01.gp_neu_id,
    v01.bq_findung_alt_id,
    v01.bq_findung_neu_id,
    SUM(v01.menge_vk_bme),
    SUM(v01.betrag_umsatz_netto),
    SUM(v01.betrag_ek_netto_alt),
    SUM(v01.betrag_ek_netto_neu),
    SUM(v01.betrag_ek_mep_alt),
    SUM(v01.betrag_ek_mep_neu)

FROM
    dbp_view.v_wup_art_gp_korrektur_1 v01

GROUP BY
    v01.mandant_id,
    v01.wup_id,
    v01.nb_id,
    v01.art_id,
    v01.dat_korrektur,
    v01.gp_alt_id,
    v01.gp_neu_id,
    v01.bq_findung_alt_id,
    v01.bq_findung_neu_id;