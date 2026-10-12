create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BESCH_FAKTURA_LGORT_WG_WUP(
	MANDANT_ID,
	SYSTEM_ID,
	WUP_ID,
	NB_ID,
	LAGERORT_ID,
	WG_ID,
	FAKTURAART_ID,
	DAT_FAKTURA,
	DAT_ERSTELLUNG,
	DAT_LEIST_ERSTELLUNG,
	ARTHIERTYP_ID,
	VERRECHNUNG_BETRAG,
	ZWSUM_1_BETRAG,
	ZWSUM_2_BETRAG,
	ZWSUM_3_BETRAG,
	ZWSUM_4_BETRAG,
	ZWSUM_5_BETRAG,
	ZWSUM_6_BETRAG,
	MENGE_FAKTURA_BME,
	MENGE_FAKTURA_KOLLI,
	MENGE_FAKTURA_PALETTE,
	AUFTRAG_GRUND_ID,
	ZWSUM_8_BETRAG,
	ZWSUM_9_BETRAG,
	BESTELLART_ID,
	DAT_PREISFINDUNG,
	AUFTRAGGEBER_ID,
	VK_NETTO_BETRAG,
	VK_NETTO_REKL_TKL_BETRAG
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 05.09.2016 twie: SPEC0014072 Filter auf Fakturaarten erweitern
-- 12.04.2018 twie: SPEC0031807 Bei bestimmten Fakturaarten wird als Fakturadatum das Leistungsdatum ausgegeben
-- 18.06.2020 dsim: SPEC0075005 Filter on rpw_fakturaarten has been added

SELECT
mandant_id,
7,
wup_id,
nb_id,
lagerort_id,
wg_id,
fakturaart_id,
CASE WHEN fakturaart_id IN ('ZVLT', 'ZMWP', 'ZGLT', 'ZGWP', 'ZSLT', 'ZSMP', 'Z5LT', 'Z5MP', 'ZEWP', 'ZSWP') THEN dat_leist_erstellung ELSE dat_faktura END AS dat_faktura,
dat_erstellung,
dat_leist_erstellung,
arthiertyp_id,
CASE
WHEN v_besch_faktura_lgort_wg_wup.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN (v_besch_faktura_lgort_wg_wup.verrechnung_betrag * -1)
ELSE v_besch_faktura_lgort_wg_wup.verrechnung_betrag
END AS verrechnung_betrag,
CASE
WHEN v_besch_faktura_lgort_wg_wup.fakturaart_id IN ('L2','ZVLT', 'ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN (v_besch_faktura_lgort_wg_wup.zwsum_1_betrag * -1)
ELSE v_besch_faktura_lgort_wg_wup.zwsum_1_betrag
END AS zwsum_1_betrag,
CASE
WHEN v_besch_faktura_lgort_wg_wup.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN (v_besch_faktura_lgort_wg_wup.zwsum_2_betrag * -1)
ELSE v_besch_faktura_lgort_wg_wup.zwsum_2_betrag
END AS zwsum_2_betrag,
CASE
WHEN v_besch_faktura_lgort_wg_wup.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN (v_besch_faktura_lgort_wg_wup.zwsum_3_betrag * -1)
ELSE v_besch_faktura_lgort_wg_wup.zwsum_3_betrag
END AS zwsum_3_betrag,
CASE
WHEN v_besch_faktura_lgort_wg_wup.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN (v_besch_faktura_lgort_wg_wup.zwsum_4_betrag * -1)
ELSE v_besch_faktura_lgort_wg_wup.zwsum_4_betrag
END AS zwsum_4_betrag,
CASE
WHEN v_besch_faktura_lgort_wg_wup.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')THEN (v_besch_faktura_lgort_wg_wup.zwsum_5_betrag * -1)
ELSE v_besch_faktura_lgort_wg_wup.zwsum_5_betrag
END AS zwsum_5_betrag,
CASE
WHEN v_besch_faktura_lgort_wg_wup.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')THEN (v_besch_faktura_lgort_wg_wup.zwsum_6_betrag * -1)
ELSE v_besch_faktura_lgort_wg_wup.zwsum_6_betrag
END AS zwsum_6_betrag,
CASE
WHEN v_besch_faktura_lgort_wg_wup.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN (v_besch_faktura_lgort_wg_wup.menge_faktura_bme * -1)
ELSE v_besch_faktura_lgort_wg_wup.menge_faktura_bme
END AS menge_faktura_bme,
CASE
WHEN v_besch_faktura_lgort_wg_wup.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')THEN (v_besch_faktura_lgort_wg_wup.menge_faktura_kolli * -1)
ELSE v_besch_faktura_lgort_wg_wup.menge_faktura_kolli
END AS menge_faktura_kolli,
CASE
WHEN v_besch_faktura_lgort_wg_wup.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN (v_besch_faktura_lgort_wg_wup.menge_faktura_palette * -1)
ELSE v_besch_faktura_lgort_wg_wup.menge_faktura_palette
END AS menge_faktura_palette,
auftrag_grund_id,
CASE
WHEN v_besch_faktura_lgort_wg_wup.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN (v_besch_faktura_lgort_wg_wup.zwsum_8_betrag * -1)
ELSE v_besch_faktura_lgort_wg_wup.zwsum_8_betrag
END AS zwsum_8_betrag,
CASE
WHEN v_besch_faktura_lgort_wg_wup.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN (v_besch_faktura_lgort_wg_wup.zwsum_9_betrag * -1)
ELSE v_besch_faktura_lgort_wg_wup.zwsum_9_betrag
END AS zwsum_9_betrag,
bestellart_id,
dat_preisfindung,
CAST(IFF(auftraggeber_id = '',0, auftraggeber_id) AS INTEGER),
CASE
WHEN v_besch_faktura_lgort_wg_wup.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN (v_besch_faktura_lgort_wg_wup.vk_netto_betrag * -1)
ELSE v_besch_faktura_lgort_wg_wup.vk_netto_betrag
END AS vk_netto_betrag,
CASE
WHEN v_besch_faktura_lgort_wg_wup.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')THEN (v_besch_faktura_lgort_wg_wup.vk_netto_rekl_tkl_betrag * -1)
ELSE v_besch_faktura_lgort_wg_wup.vk_netto_rekl_tkl_betrag
END AS vk_netto_rekl_tkl_betrag
FROM dbp_view.v_besch_faktura_lgort_wg_wup AS v_besch_faktura_lgort_wg_wup
WHERE mandant_id =1 AND fakturaart_id IN (SELECT DISTINCT fakturaart_id
FROM dbp_view.v_rpw_fakturaarten WHERE mandant_id =1 );
