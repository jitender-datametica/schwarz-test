CREATE OR REPLACE VIEW dbp_msi_view_rpw.mv_besch_faktura_lgort_wg_wup_1
-- 05.09.2016 twie: SPEC0014072 Filter auf Fakturaarten erweitern
-- 12.04.2018 twie: SPEC0031807 Bei bestimmten Fakturaarten wird als Fakturadatum das Leistungsdatum ausgegeben
-- 18.06.2020 dsim: SPEC0075005 Filter on rpw_fakturaarten_1 has been added

(
mandant_id ,
system_id,
wup_id ,
nb_id ,
lagerort_id ,
wg_id ,
fakturaart_id ,
dat_faktura,
dat_erstellung ,
dat_leist_erstellung ,
arthiertyp_id,
verrechnung_betrag,
zwsum_1_betrag ,
zwsum_2_betrag ,
zwsum_3_betrag ,
zwsum_4_betrag ,
zwsum_5_betrag ,
zwsum_6_betrag ,
menge_faktura_bme ,
menge_faktura_kolli,
menge_faktura_palette,
auftrag_grund_id,
zwsum_8_betrag,
zwsum_9_betrag,
bestellart_id,
dat_preisfindung,
auftraggeber_id,
vk_netto_betrag,
vk_netto_rekl_tkl_betrag
)
AS
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
FROM dbp_view.v_besch_faktura_lgort_wg_wup_1 AS v_besch_faktura_lgort_wg_wup_1
WHERE mandant_id =1 and fakturaart_id IN (SELECT distinct fakturaart_id
FROM dbp_view.v_rpw_fakturaarten_1 WHERE mandant_id =1 );
