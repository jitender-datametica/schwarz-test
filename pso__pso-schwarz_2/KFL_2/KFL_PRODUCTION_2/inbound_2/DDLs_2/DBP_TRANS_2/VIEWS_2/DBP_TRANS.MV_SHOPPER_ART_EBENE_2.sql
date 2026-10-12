create or replace view DBP_TRANS.MV_SHOPPER_ART_EBENE_2(
	ANZ_BON_AF,
	ANZ_BON_AKTION,
	ANZ_BON_SA,
	ANZ_CP_KAEUFER,
	ANZ_CP_KAEUFER_70_PROZENT,
	ANZ_KAEUFER_AF,
	ANZ_KAEUFER_SA,
	ANZ_MARKT_BASELINE_AF,
	ANZ_TAGE_BASELINE_AF,
	ANZ_TAGE_SA,
	ANZ_TAGE_WO1,
	ANZ_TAGE_WO2,
	ANZ_TAGE_WO3,
	ART_ID_WERBUNG,
	KL_ART_ID_LANG,
	DAT_BASELINE_BIS,
	DAT_BASELINE_VON,
	ERTRAG_BASELINE_AF,
	ERTRAG_SA,
	KAEUFER_PROZENT_BASELINE_AF,
	KAEUFER_PROZENT_SA,
	KJWO_WERBE_ENDE,
	MANDANT_ID,
	MENGE_BASELINE_AF,
	MENGE_SA,
	MENGE_WO1,
	MENGE_WO2,
	MENGE_WO3,
	UMS_AKTIVIERTER_NORMALPREIS,
	UMS_GESAMT_AF_MIT_WV,
	UMS_GESAMT_AUSSER_ARTIKEL,
	UMS_NETTO_BASELINE_AF,
	UMS_NETTO_SA,
	UMS_REST_BON_AF,
	UMS_REST_BON_GESAMT,
	VK_BRUTTO_AF_MITTEL,
	VK_BRUTTO_SA_MITTEL,
	VK_BRUTTO_SA_MAX,
	WRG_ID,
	ANZ_MARKT_SA
) as
SELECT
SUM(CAST(v01.anz_bon_af AS BIGINT)) AS anz_bon_af
, SUM(v01.anz_bon_aktion) AS anz_bon_aktion
, SUM(v01.anz_bon_sa) AS anz_bon_sa
, SUM(v01.anz_cp_kaeufer) AS anz_cp_kaeufer
, SUM(v01.anz_cp_kaeufer_70_prozent) AS anz_cp_kaeufer_70_prozent
--- Käufer Baseline (AF) und Werbewoche (SA)
--, NULLIFZERO(SUM(v01.anz_kaeufer_af)) / NULLIFZERO(SUM (anz_tage_baseline_af)) AS anz_kaeufer_af
, SUM (v01.anz_kaeufer_af) AS anz_kaeufer_af
--, NULLIFZERO(SUM(v01.anz_kaeufer_sa)) / NULLIFZERO(SUM (anz_tage_sa)) AS anz_kaeufer_sa
, SUM(v01.anz_kaeufer_sa) AS anz_kaeufer_sa
---
, SUM(v01.anz_markt_baseline_af) AS anz_markt_baseline_af
, SUM(v01.anz_tage_baseline_af) AS anz_tage_baseline_af
, SUM(v01.anz_tage_sa) AS anz_tage_sa
, SUM(v01.anz_tage_wo1) AS anz_tage_wo1
, SUM(v01.anz_tage_wo2) AS anz_tage_wo2
, SUM(v01.anz_tage_wo3) AS anz_tage_wo3
, v01.art_id_werbung
, CAST(v02.kl_art_id AS CHAR(8)) kl_art_id_lang
, MAX(v01.dat_baseline_bis)
, MIN(v01.dat_baseline_von)

, CAST(SUM(v01.ertrag_baseline_af) AS DECIMAL (18,4)) AS ertrag_baseline_af
, CAST(SUM(v01.ertrag_sa) AS DECIMAL (18,4)) AS ertrag_sa

--- Käuferreichweite Baseline (AF) und Werbewoche - falsche Berechnungsebene -> wurde in FE verlagert
, 100.00 * NULLIFZERO(SUM(v01.anz_kaeufer_af)) / NULLIFZERO(SUM(v01.anz_bon_af)) AS kaeufer_prozent_baseline_af
, 100.00 * NULLIFZERO(SUM(v01.anz_kaeufer_sa)) / NULLIFZERO(SUM(v01.anz_bon_aktion)) AS kaeufer_prozent_sa
---
, v01.kjwo_werbe_ende
, v01.mandant_id
, SUM(v01.menge_baseline_af) AS menge_baseline_af
, SUM(v01.menge_sa) AS menge_sa
, SUM(v01.menge_wo1) AS menge_wo1
, SUM(v01.menge_wo2) AS menge_wo2
, SUM(v01.menge_wo3) AS menge_wo3

-- Aktivierter Normalpreis Umsatz  - falsche Berechnungsebene -> wurde in FE verlagert
, CAST(NULLIFZERO(SUM(v01.ums_gesamt_af_mit_wv)) / NULLIFZERO(SUM(v01.anz_tage_sa)) AS DECIMAL (18,4)) AS ums_aktivierter_normalpreis
, CAST(SUM(v01.ums_gesamt_af_mit_wv) AS DECIMAL (18,4)) AS ums_gesamt_af_mit_wv
, CAST(SUM(v01.ums_gesamt_ausser_artikel) AS DECIMAL (18,4)) AS ums_gesamt_ausser_artikel
, CAST(SUM(v01.ums_netto_baseline_af) AS DECIMAL (18,4)) AS ums_netto_baseline_af
, CAST(SUM(v01.ums_netto_sa) AS DECIMAL (18,4)) AS ums_netto_sa
--- Restbon  - falsche Berechnungsebene -> wurde in FE verlagert
, CAST(NULLIFZERO(SUM(v01.ums_gesamt_af_mit_wv)) / NULLIFZERO(SUM(v01.anz_cp_kaeufer)) AS DECIMAL (18,4)) AS ums_rest_bon_af
, CAST(NULLIFZERO(SUM(v01.ums_gesamt_ausser_artikel)) / NULLIFZERO(SUM(v01.anz_cp_kaeufer)) AS DECIMAL (18,4)) AS ums_rest_bon_gesamt
--- Preispunkt AF /SA  - falsche Berechnungsebene -> wurde in FE verlagert
, CAST(SUM(v01.vk_brutto_af_mittel) AS DECIMAL (18,4)) AS vk_brutto_af_mittel
, CAST(SUM(v01.vk_brutto_sa_mittel) AS DECIMAL (18,4)) AS vk_brutto_sa_mittel
, CAST(SUM(v01.vk_brutto_sa_max) AS DECIMAL (18,4)) AS vk_brutto_sa_max
, v01.wrg_id
, SUM(v01.anz_markt_sa) AS anz_markt_sa
FROM dbp_view.v_shopper_2 v01

INNER JOIN dbp_view.v_art_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.art_id_werbung = v02.art_id

JOIN dbp_view.v_mandant_2 v100
ON v01.mandant_id = v100.mandant_id

WHERE v01.mandant_id > 1

GROUP BY
v01.aktion_thema_gruppe_id
, v01.art_id_werbung
, v02.kl_art_id
, v02.art_id
--, v01.dat_baseline_bis
--, v01.dat_baseline_von
, v01.kjwo_werbe_ende
, v01.mandant_id
, v01.wrg_id;