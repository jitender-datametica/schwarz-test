CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTBEW_MO_EK_CP_SUM_REGALACHSE
(
	KJMO,
	ART_ID,
	FBB_NR,
	FACHBODEN_NR,
	FACHBODEN_POS,
	BEWART_ID,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
    WRG_ID,
	UMSATZ_NETTO,
    BETRAG_KMEP,
    PREIS_ABSCHRIFT_NETTO
)
AS
SELECT DISTINCT
 v01.kjmo
,v01.art_id
,v02.fbb_nr
,v02.fachboden_nr
,v02.fachboden_pos
,v01.bewart_id
,v01.mandant_id
,v01.wup_id
,v01.nb_id
,v01.wrg_id
,CASE WHEN v01.wrg_id = 'EUR' AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN v01.umsatz_netto * v02.kapazitaet_faktor
      WHEN v01.wrg_id = 'EUR' AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN (v01.umsatz_netto * umrechnungskurs_hist) * v02.kapazitaet_faktor
      ELSE v01.umsatz_netto * v02.kapazitaet_faktor END AS umsatz_netto
,CASE WHEN v01.wrg_id = 'EUR' AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN v01.betrag_kmep * v02.kapazitaet_faktor
      WHEN v01.wrg_id = 'EUR' AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN (v01.betrag_kmep * umrechnungskurs_hist) * v02.kapazitaet_faktor
      ELSE v01.betrag_kmep END AS betrag_kmep
,CASE WHEN v01.wrg_id = 'EUR' AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 0 THEN v01.preis_abschrift_netto * v02.kapazitaet_faktor
      WHEN v01.wrg_id = 'EUR' AND v04.wrg_typ_id = 0 AND v04.berichtskurs_typ_id = 1 THEN (v01.preis_abschrift_netto * umrechnungskurs_hist) * v02.kapazitaet_faktor
      ELSE v01.preis_abschrift_netto END AS preis_abschrift_netto

FROM (dbp_view.v_artbew_mo_ek_cp_sum v01
INNER JOIN dbp_view.v_regalachse_akt v02
ON  v01.art_id = v02.art_id
AND v01.mandant_id = v02.mandant_id
AND v01.wup_id = v02.wup_id
AND v01.nb_id = v02.nb_id

JOIN dbp_view.v_mandant v03
ON (v01.mandant_id = v03.mandant_id))
CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v04

WHERE v01.mandant_id > 1
AND v01.wup_bereinigt_fg = 0
AND DECODE(v01.wrg_id, 'EUR', 0, 1) = DECODE(v03.default_wrg, 'EUR', 0, v04.wrg_typ_id)
--AP0190987/SPEC0225041 Filter E-Loading Artikel / sschuecke 17.11.2023
AND NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
--AP0227085/SPEC0284781 Filter E-Loading Artikel / sschuecke 25.02.2025
AND NOT (v01.mandant_id = 2 AND v01.art_id = 20812450)
AND NOT (v01.mandant_id = 3 AND v01.art_id = 20811369)
AND NOT (v01.mandant_id = 6 AND v01.art_id = 20813157)
AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 20811474)
AND NOT (v01.mandant_id = 8 AND v01.art_id = 20813164)
AND NOT (umsatz_netto = 0 AND betrag_kmep IS NULL AND preis_abschrift_netto = 0);