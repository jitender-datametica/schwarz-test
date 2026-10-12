CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LAGERBEW_LGORT_GRUND_WUP
(
	MANDANT_ID,
	MANDANT_ID_EMPFAENGER,
	LAGERORT_ID,
	GRUND_ID,
	WUP_ID,
	NB_ID,
	AUTO_FG,
	DAT_BUCH,
	VORGANGSART_ID,
	LAGER_BEWART_ID,
	WG_ID,
	ARTHIERTYP_ID,
	EMPFAENGER_ID,
	BETRAG_LAGERBEW,
	BETRAG_VERKAUF,
	MENGE_LAGERBEW_BME,
	MENGE_LIEF,
	MENGE_LIEFERSCHEIN,
	MENGE_LAGERBEW_KOLLI,
	MENGE_LAGERBEW_PALETTE,
	MENGE_ERF,
	WRG_ID,
	WRG_TYP_ID,
	BETRAG_VK_NETTO_VZ,
	LIEF_PAL_TYP_ID
) AS
-- 14.11.2019, AP0050464, nwag2310 Anpassung Moldau BEWART 643/644
-- 09.02.2021, AP0078007, SPEC0101516, srom0404, lief_pal_typ_id auf CHAR(2)
-- 20.12.2021, AP0105952, SPEC0137510, dknop, expanding contion, adding Z11
-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu ersetzen durch neue View (Projektspezifische Waehrungsauswahl) 
-- 2024-07-23,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
-- 2024-07-23,AP0204035, SPEC0254614,dknop, updating aktuell_wup_id logic
SELECT
v01.mandant_id
, CASE WHEN v01.empfaenger_id IS NULL THEN 0 ELSE COALESCE(v05.aktuell_wup_id,v01.empfaenger_id) END AS empfaenger_id
, v01.lagerort_id
, v01.grund_id
, v01.wup_id
, v01.nb_id
, v01.auto_fg
, v01.dat_buch
, v01.vorgangsart_id
, v01.lager_bewart_id
, v01.wg_id
, v01.arthiertyp_id
--, CASE WHEN v01.empfaenger_id IS NULL THEN 0 ELSE v01.empfaenger_id END AS empfaenger_id
, CASE WHEN v01.empfaenger_id IS NULL THEN 0 ELSE v05.aktuell_wup_id END AS empfaenger_id
-- Incident WOL3467619, Ergänzung der Storno- und Korrekturbuchungen (BWA 302;312;602;642;648)
, CASE WHEN v03.wrg_typ_id = 0 THEN v01.betrag_lagerbew * v02.umrechnungskurs ELSE v01.betrag_lagerbew END * CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN -1 ELSE 1 END AS betrag_lagerbew
, CASE WHEN v03.wrg_typ_id = 0 THEN v01.betrag_verkauf * v02.umrechnungskurs ELSE betrag_verkauf END * CASE WHEN lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN -1 ELSE 1 END AS betrag_verkauf
, CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lagerbew_bme * -1 ELSE v01.menge_lagerbew_bme END AS menge_lagerbew_bme
, CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lief * -1 ELSE v01.menge_lief END AS menge_lief
, CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lieferschein * 1 ELSE v01.menge_lieferschein END AS menge_lieferschein
, CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lagerbew_kolli * -1 ELSE v01.menge_lagerbew_kolli END AS menge_lagerbew_kolli
, CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lagerbew_palette * -1 ELSE v01.menge_lagerbew_palette END AS menge_lagerbew_palette
, CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_erf * -1 ELSE v01.menge_erf END AS menge_erf
, v03.wrg_id
, v03.wrg_typ_id
, CASE WHEN v03.wrg_typ_id = 0 THEN v01.betrag_vk_netto_vz * v02.umrechnungskurs ELSE v01.betrag_vk_netto_vz END * CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN -1 ELSE 1 END AS betrag_vk_netto_vz
, Cast(v01.lief_pal_typ_id AS VARCHAR(2)) AS lief_pal_typ_id

FROM DBP_VIEW.v_lagerbew_lgort_grund_wup v01

LEFT JOIN dbp_view.v_wup v05
   ON v05.mandant_id = v01.mandant_id_empfaenger 
   AND v05.wup_id = v01.empfaenger_id
   AND v05.nb_id = 0

JOIN DBP_MSI_VIEW3.mv_kurs v02
ON v01.wrg_id=v02.von_wrg_id
JOIN DBP_VIEW.v_mandant_wrg_typ_zu v03
ON v01.mandant_id=v03.mandant_id

JOIN dbp_msi_view3.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU v04
ON v03.wrg_typ_id = v04.wrg_typ_id

WHERE v01.lagerort_id NOT IN ('-1', '-2', '-3');