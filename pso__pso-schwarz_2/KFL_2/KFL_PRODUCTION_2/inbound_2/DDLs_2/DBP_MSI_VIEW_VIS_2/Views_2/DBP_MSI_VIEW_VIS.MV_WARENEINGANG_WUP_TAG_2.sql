CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WARENEINGANG_WUP_TAG_2 (
	MANDANT_ID,
	WUP_ID,
	JAHR,
	DAT,
	ART_ID,
	WRG_ID,
	LAGER_BEWART_ID,
	GP_ID,
	MENGE_DZ,
	MENGE_RET_DZ,
	BETRAG_VK_NETTO_DZ,
	MENGE_ZL,
	MENGE_RET_ZL,
	BETRAG_VK_NETTO_ZL,
	QUELLE
	) AS
/*
2025-7-01 muellerpatri : Initiale Erstellung der View (AP0274731)
*/
WITH 
wup_2 AS (
	SELECT mandant_id
		, wup_id
		, aktuell_wup_id
	FROM dbp_view.v_wup_2
	),
wewa_2 AS (
	SELECT mandant_id
		, wup_id
		, wewa_jahr
		, dat_buch
		, art_id
		, wrg_id
		, lager_bewart_id
		, gp_id
		, SUM(CASE WHEN lager_bewart_id IN (101, 102, 901, 902) AND nb_id = 0 THEN menge_basis ELSE 0 END) AS menge_dz
		, SUM(CASE WHEN lager_bewart_id IN (161, 162) AND nb_id = 0 THEN menge_basis ELSE 0 END) AS menge_ret_dz
		, SUM(CASE WHEN lager_bewart_id IN (101, 102, 901, 902, 161, 162) AND nb_id = 0 THEN betrag_vk_netto ELSE 0 END) AS betrag_vk_netto_dz
		, 'wewa_2' AS quelle
	FROM dbp_view.v_wewa_2 
	WHERE mandant_id <> 1
		AND lager_bewart_id IN (101, 102, 901, 902, 161, 162)
		AND nb_id = 0
		AND dat_buch BETWEEN CURRENT_DATE - 366 AND CURRENT_DATE -- to ensure for whole current business year
		AND art_id >= 0 -- exclude negative kl_art_nr
	GROUP BY mandant_id
		, wup_id
		, wewa_jahr
		, dat_buch
		, art_id
		, wrg_id
		, lager_bewart_id
		, gp_id
	),
lager AS (
	SELECT mandant_id
		, wup_id           
		, kj
		, dat_buch
		, art_id
		, wrg_id                                            
		, lager_bewart_id
		, gp_id
		, SUM(CASE WHEN lager_bewart_id IN ('641', '647', '301', '311') THEN ABS(menge_lagerbew_bme) ELSE 0 END) AS menge_zl 
		, SUM(CASE WHEN lager_bewart_id IN ('642', '648', '302', '312') THEN ABS(menge_lagerbew_bme) * -1 ELSE 0 END) AS menge_ret_zl -- can differ between positive and negative based on Haben or Soll and therefore change all values to negative  
		, SUM(CASE 
			WHEN lager_bewart_id IN ('641', '647', '301', '311') THEN ABS(betrag_vk_netto)
			WHEN lager_bewart_id IN ('642', '648', '302', '312') THEN ABS(betrag_vk_netto) * -1 -- can differ between positive and negative based on Haben or Soll and therefore change all values to negative 
			ELSE 0 
			END) AS betrag_vk_netto_zl
		, 'lagerbew_det_2' AS quelle
	FROM dbp_view.v_lagerbew_det_2 lager
	WHERE mandant_id <> 1
		AND lager_bewart_id IN ('641', '647', '301', '311', '642', '648', '302', '312')
		AND dat_buch BETWEEN CURRENT_DATE - 366 AND CURRENT_DATE -- to ensure for whole current business year
		AND art_id >= 0 -- exclude negative kl_art_nr
	GROUP BY mandant_id
		, wup_id
		, kj
		, dat_buch
		, art_id
		, wrg_id
		, lager_bewart_id
		, gp_id
	),
facts_wewa_lager AS (
	SELECT w.mandant_id
		, w.wup_id
		, w.wewa_jahr AS jahr
		, w.dat_buch
		, w.art_id
		, w.wrg_id
		, w.lager_bewart_id
		, w.gp_id
		, w.menge_dz
		, w.menge_ret_dz
		, w.betrag_vk_netto_dz
		, ZEROIFNULL(l.menge_zl) AS menge_zl
		, ZEROIFNULL(l.menge_ret_zl) AS menge_ret_zl
		, ZEROIFNULL(l.betrag_vk_netto_zl) AS betrag_vk_netto_zl
		, w.quelle
	FROM wewa_2 w
	LEFT JOIN lager l
		ON w.mandant_id = l.mandant_id
			AND w.wup_id = l.wup_id
			AND w.wewa_jahr = l.kj
			AND w.dat_buch = l.dat_buch
			AND w.art_id = l.art_id
			AND w.wrg_id = l.wrg_id
			AND w.lager_bewart_id = l.lager_bewart_id
			AND w.gp_id = l.gp_id
	UNION ALL
	SELECT l.mandant_id
		, l.wup_id
		, l.kj AS jahr
		, l.dat_buch
		, l.art_id
		, l.wrg_id
		, l.lager_bewart_id
		, l.gp_id
		, ZEROIFNULL(w.menge_dz) AS menge_dz
		, ZEROIFNULL(w.menge_ret_dz) AS menge_ret_dz
		, ZEROIFNULL(w.betrag_vk_netto_dz) AS betrag_vk_netto_dz
		, l.menge_zl
		, l.menge_ret_zl
		, l.betrag_vk_netto_zl
		, l.quelle
	FROM lager l
	LEFT JOIN wewa_2 w
		ON l.mandant_id = w.mandant_id
			AND l.wup_id = w.wup_id
			AND w.wewa_jahr = l.kj
			AND l.dat_buch = w.dat_buch
			AND l.art_id = w.art_id
			AND l.wrg_id = w.wrg_id
			AND l.lager_bewart_id = w.lager_bewart_id
			AND l.gp_id = w.gp_id
	WHERE w.mandant_id IS NULL -- Only include rows from lager that weren't matched in the first left join 
)
SELECT f.mandant_id
	, w.aktuell_wup_id AS wup_id
	, f.jahr
	, f.dat_buch AS dat
	, f.art_id
	, k.nach_wrg_id AS wrg_id
	, f.lager_bewart_id
	, f.gp_id
	, f.menge_dz
	, f.menge_ret_dz
	, f.betrag_vk_netto_dz * k.umrechnungskurs AS betrag_vk_netto_dz
	, f.menge_zl
	, f.menge_ret_zl
	, f.betrag_vk_netto_zl * k.umrechnungskurs AS betrag_vk_netto_zl
	, f.quelle
FROM facts_wewa_lager f
INNER JOIN wup_2 w
	ON f.mandant_id = w.mandant_id 
		AND f.wup_id = w.wup_id
INNER JOIN dbp_msi_view_vis.mv_kurs_umrechnung_2 k
	ON f.wrg_id = k.von_wrg_id
;
