create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_SPANNE_WB_1(
	DAT,
	BELEG_WB_ID,
	BELEG_WB_POS_ID,
	MANDANT_ID,
	SYSTEM_ID,
	ABS_ID,
	RCV_ID,
	ART_ID,
	BEW_ART_WB_ID,
	VK_BRUTTO,
	EK_NETTO,
	MWST,
	MWST_ID,
	HERKUNFT,
	MENGE
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 05.09.2016 twie: SPEC0014072 Filter auf Fakturaarten erweitern
-- 18.06.2020 dsim: SPEC0075005 Filter on rpw_fakturaarten_1 has been added

SELECT
bf.dat_lagerbew_ist AS dat_,
bfd.lief_beleg_id,
bfd.lief_beleg_pos_id,
bfd.mandant_id,
7 AS system_id,
CASE WHEN merker = 1
THEN bfd.wup_id
ELSE TO_NUMBER(bf.auftraggeber_id)
END AS abs_id,
CASE WHEN merker = 1
THEN TO_NUMBER(bf.auftraggeber_id)
ELSE bfd.wup_id
END AS rcv_id,
bfd.art_id,
bf.lief_typ_id,
CAST(CASE WHEN merker = 1
THEN COALESCE((zekp.ek_netto * zekp.komponentenmenge), (zekp_gp.ek_netto * zekp_gp.komponentenmenge)) * bfd.menge_lief_ist_lme
ELSE COALESCE((zekp.ek_netto * zekp.komponentenmenge), (zekp_gp.ek_netto * zekp_gp.komponentenmenge)) * bfd.menge_lief_ist_lme * (-1)
END
AS DECIMAL(18,3)) AS ek_netto,
CAST(CASE WHEN merker = 1
THEN COALESCE((zekp.ek_netto_bnk * zekp.komponentenmenge), (zekp_gp.ek_netto_bnk * zekp_gp.komponentenmenge)) * bfd.menge_lief_ist_lme
ELSE COALESCE((zekp.ek_netto_bnk * zekp.komponentenmenge), (zekp_gp.ek_netto_bnk * zekp_gp.komponentenmenge)) * bfd.menge_lief_ist_lme* (-1)
END
AS DECIMAL(18,3)) AS ek_netto_bnk,
mp.mwst AS mwst,
mp.mwst_id AS mwst_id,
'Umlagerung_1 VZ => VZ oder Lieferant => Markt                            ' AS herkunft,
CASE WHEN merker = 1
THEN bfd.menge_lief_ist_lme
ELSE bfd.menge_lief_ist_lme   * (-1.0)
END AS menge
FROM dbp_view.v_besch_lief_det_1 bfd

JOIN
(SELECT
1 AS merker
FROM dbp_msi_view_rpw.mv_spr_1 WHERE spr_id IN (22)
UNION ALL
SELECT
2 AS merker
FROM dbp_msi_view_rpw.mv_spr_1 WHERE spr_id IN (22)
) AS test_1
ON 1 = 1

JOIN dbp_view.v_besch_lief_1 bf
ON bf.lief_beleg_id = bfd.lief_beleg_id
AND bf.mandant_id = bfd.mandant_id
AND bf.dat_lief_soll  = bfd.dat_lief_soll
AND bf.lief_typ_id = 'YU'

JOIN dbp_view.v_art_1 a
ON a.art_id = bfd.art_id
AND a.mandant_id = bfd.mandant_id

JOIN dbp_view.v_mwst_per_1 mp
ON mp.mwst_id = a.mwst_id
AND mp.mandant_id = a.mandant_id
AND bf.dat_lagerbew_ist BETWEEN mp.dat_von AND mp.dat_bis

JOIN dbp_view.v_art_gp_zu_per_1 agz
ON agz.art_id = bfd.art_id
AND agz.mandant_id = bfd.mandant_id
AND bf.dat_lief_soll BETWEEN agz.dat_von AND agz.dat_bis

LEFT OUTER JOIN dbp_view.v_art_gp_wup_zu_per_1  zekp_1
ON    zekp.art_id = bfd.art_id
AND zekp.mandant_id = bfd.mandant_id
AND zekp.gp_id = agz.gp_id
AND (CASE WHEN bfd.nb_id = -111 THEN bfd.wup_id ELSE -1 END) = zekp.wup_id
AND (CASE WHEN bfd.nb_id = -111 THEN bfd.nb_id ELSE -1 END)  = COALESCE(zekp.nb_id,-1)
AND bf.dat_lagerbew_ist BETWEEN zekp.dat_von AND zekp.dat_bis

LEFT OUTER JOIN dbp_view.v_art_gp_wup_zu_per_1  zekp_gp
ON    zekp_gp.art_id = bfd.art_id
AND zekp_gp.mandant_id = bfd.mandant_id
AND zekp_gp.gp_id <> agz.gp_id
AND (CASE WHEN bfd.nb_id = -111 THEN bfd.wup_id ELSE -1 END) = zekp_gp.wup_id
AND (CASE WHEN bfd.nb_id = -111 THEN bfd.nb_id ELSE -1 END)  = COALESCE(zekp_gp.nb_id,-1)
AND bf.dat_lagerbew_ist BETWEEN zekp_gp.dat_von AND zekp_gp.dat_bis

WHERE bfd.mandant_id = 1 AND bfd.nb_id <> 99

UNION ALL
SELECT
lb.dat_buch AS dat_,
COALESCE(brd.rech_beleg_id ,lb.lagerbew_beleg_id) AS beleg_wb_id,
COALESCE(brd.rech_beleg_pos_id ,lb.lagerbew_beleg_pos_id) AS beleg_wb_pos_id,
lb.mandant_id,
7 AS system_id,
CASE WHEN lb.lager_bewart_id  IN ('303','304','301','302')
THEN lb.wup_id
ELSE lb.gp_id
END AS abs_id,
CASE WHEN lb.lager_bewart_id  IN ('303','304','301','302')
THEN lb.empfaenger_id
ELSE lb.wup_id
END AS rcv_id,
lb.art_id,
lb.lager_bewart_id AS bew_art_wb_id,
CASE WHEN lb.lager_bewart_id  IN ('303', '304','301','302')
THEN COALESCE (brd.betrag_vk_brutto ,lb.betrag_verkauf) * -1
ELSE COALESCE (brd.betrag_vk_brutto ,lb.betrag_verkauf)
END  AS vk_brutto,
CASE WHEN a.wg_art_fg = 1
THEN CASE WHEN lb.lager_bewart_id  IN ('303', '304','301','302')
THEN (betrag_vk_netto) * 0.90 * -1
ELSE COALESCE(brd.betrag_beleg,(betrag_belegfluss_wg_art * -1))
END
ELSE CASE WHEN lb.lager_bewart_id  IN ('303', '304','301','302')
THEN COALESCE(brd.betrag_beleg, betrag_lagerbew) * -1
ELSE COALESCE(brd.betrag_beleg, betrag_lagerbew)
END
END AS ek_netto,
mp.mwst AS mwst,
mp.mwst_id,
'Dezentral Lieferant => VZ/Markt sowie Umlagerung_1 Markt => Markt' AS herkunft,
CASE WHEN lb.lager_bewart_id  IN ('303','304','301','302')
THEN COALESCE(brd.best_preis_menge,lb.menge_erf) * -1.0
ELSE COALESCE(brd.best_preis_menge,lb.menge_lief)
END  AS menge
FROM dbp_msi_view_rpw.mv_lagerbew_det_1 lb

JOIN dbp_msi_view_rpw.mv_lagerbew_1 l_
ON l_.lagerbew_beleg_id = lb.lagerbew_beleg_id
AND l_.kj = lb.kj
AND l_.mandant_id = lb.mandant_id
AND l_.dat_buch = lb.dat_buch

JOIN dbp_view.v_art_1 a
ON a.art_id = lb.art_id
AND a.mandant_id = lb.mandant_id

JOIN dbp_view.v_mwst_per_1 mp
ON mp.mwst_id = a.mwst_id
AND mp.mandant_id = a.mandant_id
AND lb.dat_buch BETWEEN mp.dat_von AND mp.dat_bis


LEFT OUTER JOIN
(SELECT
brd.*
FROM dbp_view.v_besch_rech_det_1 brd

INNER JOIN dbp_view.v_besch_rech_1  br
ON brd.rech_beleg_id = br.rech_beleg_id
AND brd.gj  = br.gj
AND brd.mandant_id = br.mandant_id
AND br.rech_beleg_storno_id IS NULL
AND br.vorgangsart_ag08_id <>'KP'
) brd
ON lb.lagerbew_beleg_id  = brd.lagerbew_beleg_id
AND lb.lagerbew_beleg_pos_id = brd.lagerbew_beleg_pos_id
AND lb.kj  = brd.kj
AND lb.mandant_id = brd.mandant_id

WHERE lb.mandant_id = 1
AND lb.lager_bewart_id NOT IN ('305','309','310','317','318','319','320','903', '904', '913', '914','915','916')
AND (lb.gp_id IS  NULL OR (lb.gp_id <= 6900 OR lb.gp_id >= 6914))

UNION ALL
SELECT
lk.dat_faktura AS dat_,
lb.faktura_beleg_id,
lb.faktura_beleg_pos_id,
lb.mandant_id,
7 AS system_id,
lb.wup_id,
TRY_TO_NUMERIC(lk.auftraggeber_id),
lb.art_id,
lk.fakturaart_id,
CASE WHEN lk.fakturaart_id IN ('L2  ','ZVLT','ZMWP','S2  ','Z5LT','Z5MP','ZSWP','ZGEP','ZF1 ','ZIV ','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN (lb.zwsum_2_betrag + lb.zwsum_5_betrag + lb.zwsum_8_betrag)
ELSE (lb.zwsum_2_betrag + lb.zwsum_5_betrag + lb.zwsum_8_betrag)*(-1)
END,
CASE WHEN lk.fakturaart_id IN ('L2  ','ZVLT','ZMWP','S2  ','Z5LT','Z5MP','ZSWP','ZGEP','ZF1 ','ZIV ','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN lb.zwsum_3_betrag
ELSE lb.zwsum_3_betrag *(-1)
END,
mp.mwst AS mwst,
mp.mwst_id,
'Zentral VZ => Markt (""Faktura"")' AS herkunft,
CASE WHEN lk.fakturaart_id IN ('L2  ','ZVLT','ZMWP','S2  ','Z5LT','Z5MP','ZSWP','ZGEP','ZF1 ','ZIV ','ZLF2','ZLL2','ZLRS','ZLS2','ZLUL')
THEN lb.menge_faktura_bme
ELSE (lb.menge_faktura_bme )* (-1)
END AS menge
FROM dbp_view.v_besch_faktura_det_1 lb

JOIN dbp_view.v_besch_faktura_1 lk
ON lb.mandant_id = lk.mandant_id
AND lb.faktura_beleg_id = lk.faktura_beleg_id
AND lb.dat_faktura=lk.dat_faktura

JOIN dbp_view.v_art_1 a
ON a.art_id = lb.art_id
AND a.mandant_id = lb.mandant_id

JOIN dbp_view.v_mwst_per_1 mp
ON mp.mwst_id = a.mwst_id
AND mp.mandant_id = a.mandant_id
AND lk.dat_faktura BETWEEN mp.dat_von AND mp.dat_bis

JOIN (SELECT  DISTINCT mandant_id,
fakturaart_id
FROM dbp_view.v_rpw_fakturaarten_1
)lkf
ON lkf.mandant_id = lk.mandant_id
AND lkf.fakturaart_id = lk.fakturaart_id

WHERE lb.mandant_id = 1 AND lb.wup_id BETWEEN 6900 AND 6914;
