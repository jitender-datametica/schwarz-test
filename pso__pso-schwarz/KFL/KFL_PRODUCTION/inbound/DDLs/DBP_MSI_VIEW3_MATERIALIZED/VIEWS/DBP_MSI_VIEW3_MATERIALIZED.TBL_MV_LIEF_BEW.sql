create or replace view DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_LIEF_BEW(
	LIEF_BELEG_ID,
	LIEF_PAL_TYP_ID,
	VERSANDSTELLE_ID,
	WERBEWARE_ID,
	KUNDE_ID_,
	MANDANT_ID_KUNDE_,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DAT_LIEF_SOLL_,
	REF_LAGERBEW_BELEG_ID_NUM,
	KJ,
	LAGERBEW_BELEG_ID,
	DAT_BUCH,
	LAGER_BEWART_ID,
	WG_VERKETT_ID,
	WRG_ID,
	WRG_TYP_ID,
	BETRAG_LAGERBEW,
	UMRECHNUNGSKURS,
	V04_MANDANT_ID,
	MENGE_LIEF_IST_KOLLI,
	ANZAHL_PACKSTUECK,
	BETRAG_VK_NETTO_VZ
) as





SELECT
v02.lief_beleg_id
, v02.lief_pal_typ_id
, v02.versandstelle_id
, v02.werbeware_id

, CASE WHEN TRY_CAST(SUBSTR(v02.kunde_id,7,4) AS INTEGER) IS NULL THEN -3 ELSE v09.aktuell_wup_id END kunde_id

, CASE WHEN v02.mandant_id_kunde IS NULL OR v02.mandant_id_kunde = 0 THEN v02.mandant_id ELSE v02.mandant_id_kunde END AS mandant_id_kunde_
, v01.mandant_id
, v01.wup_id
, v01.nb_id
, v01.dat_lief_soll AS dat_lief_soll_
, v03.ref_lagerbew_beleg_id_num
, v03.kj
, v03.lagerbew_beleg_id
, v04.dat_buch
, v04.lager_bewart_id
, v06.wg_verkett_id
, v08.wrg_id
, v08.wrg_typ_id
, v04.betrag_lagerbew
, v07.umrechnungskurs
, v04.mandant_id AS v04_mandant_id
, v01.menge_lief_ist_kolli
, v02.anzahl_packstueck
, v04.betrag_vk_netto_vz
FROM dbp_view.v_besch_lief_det v01

JOIN dbp_view.v_besch_lief v02
ON v01.lief_beleg_id = v02.lief_beleg_id
AND v01.mandant_id = v02.mandant_id
AND v01.kj = v02.kj
AND v01.dat_lief_soll = v02.dat_lief_soll

INNER JOIN dbp_view.v_wup v09
   ON v09.mandant_id = CASE WHEN v02.mandant_id_kunde IS NULL OR v02.mandant_id_kunde = 0 THEN v02.mandant_id ELSE v02.mandant_id_kunde END
   AND v09.wup_id = CASE WHEN TRY_CAST(v02.kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(v02.kunde_id AS INTEGER) END
   AND ((v09.nb_id IN (2, 0, -111) AND v09.wup_id > 0) OR (v09.nb_id = -1 AND v09.wup_id = 0))

JOIN dbp_view.v_lagerbew v03
ON v02.lief_beleg_id = v03.ref_lagerbew_beleg_id_num
AND ABS(v02.kj - v03.kj) <= 1 
AND v02.mandant_id = v03.mandant_id

JOIN dbp_view.v_lagerbew_det v04
ON v03.lagerbew_beleg_id = v04.lagerbew_beleg_id
AND v03.mandant_id = v04.mandant_id
AND v03.kj = v04.kj
AND v01.art_id = v04.art_id
AND v03.dat_buch = v04.dat_buch
AND v01.wup_id = v04.wup_id

JOIN dbp_view.v_art_wg_zu_per v05
ON v04.art_id = v05.art_id
AND v04.mandant_id = v05.mandant_id
AND v05.arthiertyp_id=2
AND v05.dat_bis='9999-12-31'

JOIN dbp_view.v_art_wup_status_per v06
ON v01.art_id = v06.art_id
AND v01.mandant_id = v06.mandant_id
AND v01.nb_id = v06.nb_id
AND v01.wup_id = v06.wup_id
AND v06.nb_id = -111
AND v06.dat_bis='9999-12-31'

JOIN DBP_MSI_VIEW3_MATERIALIZED.mv_kurs v07
ON v01.wrg_id=v07.von_wrg_id

JOIN dbp_view.v_mandant_wrg_typ_zu v08
ON v01.mandant_id=v08.mandant_id

WHERE v04.lagerort_id NOT IN ('-1', '-2', '-3')
AND NOT ((v05.wg_id = 980 AND v05.mandant_id = 1 AND v05.arthiertyp_id = 2)
OR  (v05.wg_id=981 AND v05.mandant_id=1 AND v05.arthiertyp_id=2)
OR  (v05.wg_id=982 AND v05.mandant_id=1 AND v05.arthiertyp_id=2)
OR  (v05.wg_id=983 AND v05.mandant_id=1 AND v05.arthiertyp_id=2))
AND (NOT (v05.mandant_id <> 1 AND v05.wg_id IN (980,981,982,983)))
AND EXTRACT(YEAR FROM v01.dat_lief_soll) >= YEAR(CURRENT_TIMESTAMP) - 2;