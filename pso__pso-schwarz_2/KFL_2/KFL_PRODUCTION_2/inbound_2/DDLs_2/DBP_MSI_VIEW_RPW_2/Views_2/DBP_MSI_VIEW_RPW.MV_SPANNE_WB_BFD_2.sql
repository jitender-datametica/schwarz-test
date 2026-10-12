CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_SPANNE_WB_BFD_2
(
dat
,beleg_wb_id
,beleg_wb_pos_id
,mandant_id
,system_id
,abs_id
,rcv_id
,art_id
,bew_art_wb_id
,vk_brutto
,ek_netto
,mwst
,mwst_id
,spanne_wb_herkunft_id
,menge
,belastungsart_id
,belastungsart_vd_id
) AS
-- 05.09.2016 twie: SPEC0014072 Filter auf Fakturaarten erweitern
-- 08.08.2018 twie: NSR0285945 Bei bestimmten Fakturaarten wird statt Fakturadatum das Leistungsdatum ausgegeben
-- 18.06.2020 dsim: SPEC0075005 Filter on rpw_fakturaarten_2 has been added
-- 19.07.2023 twie: SPEC0064436 belastungsart hinzu

SELECT
CASE WHEN lk.fakturaart_id IN ('ZVLT', 'ZMWP', 'ZGLT', 'ZGWP', 'ZSLT', 'ZSMP', 'Z5LT', 'Z5MP', 'ZEWP', 'ZSWP') THEN lb.dat_leist_erstellung ELSE lb.dat_faktura END AS dat,
lb.faktura_beleg_id,
lb.faktura_beleg_pos_id,
lb.mandant_id,
7 AS system_id,
lb.wup_id,
CAST(CASE WHEN lk.auftraggeber_id = '' THEN 0 ELSE lk.auftraggeber_id END AS INTEGER),
lb.art_id,
lk.fakturaart_id,
CASE
WHEN lk.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN (lb.zwsum_2_betrag + lb.zwsum_5_betrag + lb.zwsum_8_betrag)
ELSE (lb.zwsum_2_betrag + lb.zwsum_5_betrag + lb.zwsum_8_betrag)*(-1)
END,
CASE
WHEN lk.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN lb.zwsum_3_betrag
ELSE lb.zwsum_3_betrag *(-1)
END,
mp.mwst AS mwst,
mp.mwst_id,
3  AS spanne_wb_herkunft_id,
CASE
WHEN lk.fakturaart_id IN ('L2','ZVLT','ZMWP','S2','Z5LT','Z5MP','ZSWP','ZGEP','ZF1','ZIV','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN lb.menge_faktura_bme
ELSE (lb.menge_faktura_bme )* (-1)
END AS menge,
lk.fakturaart_id AS belastungsart_id,
1 AS belastungsart_vd_id

FROM dbp_view.v_besch_faktura_det_2 lb

JOIN dbp_view.v_besch_faktura_2 lk
ON lb.mandant_id = lk.mandant_id
AND lb.faktura_beleg_id = lk.faktura_beleg_id

JOIN dbp_view.v_art_2 a
ON a.art_id = lb.art_id
AND a.mandant_id = lb.mandant_id

JOIN dbp_view.v_mwst_per_2 mp
ON mp.mwst_id = a.mwst_id
AND mp.mandant_id = a.mandant_id
AND lk.dat_faktura BETWEEN mp.dat_von
AND mp.dat_bis

JOIN (SELECT  DISTINCT mandant_id,
fakturaart_id
FROM dbp_view.v_rpw_fakturaarten_2
)lkf
ON lkf.mandant_id = lk.mandant_id
AND lkf.fakturaart_id = lk.fakturaart_id

WHERE lb.mandant_id = 1;