CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ARTBEW_MO_SUM_BER_1
(
	KJMO,
	ART_ID,
	MANDANT_ID,
	GP_ID,
	NB_ID,
	WUP_ID,
	BEWART_ID,
	BEWART_DET_ID,
	BQ_FINDUNG_ID,
	BEZUGSWEG_ID,
	POSTEN_ID,
	POSTEN_KZ,
	POSTEN_ID_PER,
	POSTEN_KZ_PER,
	WUP_BEREINIGT_FG,
	WUP_BEREINIGT_FG_VJ,
	EAN_KASSE,
	UMSATZ_NETTO,
	VK_MENGE,
	UMSATZ_NETTO_AF,
	VK_MENGE_AF,
	UMSATZ_NETTO_SA,
	VK_MENGE_SA
) 
AS
SELECT
v01.kjmo,
v01.art_id,
v01.mandant_id,
v01.gp_id,
v01.nb_id,
v01.wup_id,
v01.bewart_id,
v01.bewart_det_id,
v01.bq_findung_id,
v01.bezugsweg_id,
v01.posten_id,
v01.posten_kz,
v01.posten_id_per,
v01.posten_kz_per,
v01.wup_bereinigt_fg,
v01.wup_bereinigt_fg_vj,
v01.ean_kasse,

ZEROIFNULL(CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
                WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
                ELSE CAST(v01.umsatz_netto AS NUMBER(38,5)) END) umsatz_netto,
ZEROIFNULL(CAST(v01.menge AS NUMBER(38,5))) AS vk_menge,

ZEROIFNULL(CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1  AND v01.bewart_id IN(1001,1010) THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
                WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1  AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
				WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
                WHEN v02.wrg_typ_id = 1 AND v01.bewart_id IN(1001,1010) THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END) umsatz_netto_af,
ZEROIFNULL(CASE WHEN v01.bewart_id IN(1001,1010) THEN CAST(v01.menge AS NUMBER(38,5)) END) vk_menge_af,

ZEROIFNULL(CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1  AND v01.bewart_id = 1002 THEN CAST(v01.diff_umsatz_netto_konz AS NUMBER(38,5))
                WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1  AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMBER(38,5))
				WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5))
                WHEN v02.wrg_typ_id = 1 AND v01.bewart_id = 1002 THEN CAST(v01.umsatz_netto AS NUMBER(38,5)) END) umsatz_netto_sa,
ZEROIFNULL(CASE WHEN v01.bewart_id = 1002 THEN CAST(v01.menge AS NUMBER(38,5)) END) vk_menge_sa

FROM DBP_MSI_VIEW_AIS_INT.TBL_MV_ARTBEW_MO_SUM_BER_1 v01

CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v02;