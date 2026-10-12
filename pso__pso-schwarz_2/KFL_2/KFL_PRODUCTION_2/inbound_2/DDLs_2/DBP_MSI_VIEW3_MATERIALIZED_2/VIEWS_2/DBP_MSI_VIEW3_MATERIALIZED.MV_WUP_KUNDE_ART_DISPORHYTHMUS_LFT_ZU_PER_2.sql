create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_WUP_KUNDE_ART_DISPORHYTHMUS_LFT_ZU_PER_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	MANDANT_ID_KUNDE,
	KUNDE_ID,
	AUSLIEFERUNGSGRUPPE_ID,
	TERMINIERUNGSGRUPPE_1_ID,
	TERMINIERUNGSGRUPPE_2_ID,
	TERMINIERUNGSGRUPPE_3_ID,
	DISPOSITION_RHYTHMUS_LTF_ID,
	WG_ID,
	ARTHIERTYP_ID,
	AUSG_MENGE_EINH_ID,
	PALETTEN_FAKTOR_EINH_ID,
	ART_ID,
	DISPONENT_ID,
	WG_VERKETT_ID,
	DAT_LIEF_SOLL,
	LAGERNUMMER_ID,
	LAGERORT_ID,
	LIEF_PAL_TYP_ID,
	BESTELLART_ID,
	MENGE_LIEF_IST_KOLLI
) as










SELECT
v05.mandant_id,
v05.wup_id 
,
v05.nb_id  
,
v05.mandant_id AS mandant_id_kunde,

CASE WHEN TRY_CAST(v05.kunde_id AS INTEGER) = 0 THEN NULL ELSE v06.aktuell_wup_id END kunde_id,
CAST(COALESCE(v01.auslieferungsgruppe_id,'-1') AS CHAR(4)) AS auslieferungsgruppe_id,
CAST(COALESCE(v01.terminierungsgruppe_1_id,'-1') AS CHAR(3)) AS terminierungsgruppe_1_id,
CAST(COALESCE(v01.terminierungsgruppe_2_id,'-1') AS CHAR(2)) AS terminierungsgruppe_2_id,
CAST(COALESCE(v01.terminierungsgruppe_3_id,'-1') AS CHAR(2)) AS terminierungsgruppe_3_id,
CAST(COALESCE(v01.disposition_rhythmus_ltf_id,'-1') AS CHAR(3)) AS disposition_rhythmus_ltf_id,
v02.wg_id,
v02.arthiertyp_id,
v03.ausg_menge_einh_id,
v03.paletten_faktor_einh_id,
v05.art_id,
v04.disponent_id,
v04.wg_verkett_id,
v05.dat_lief_soll,
v05.lagernummer_id,
v05.lagerort_id,
CAST(v05.lief_pal_typ_id AS CHAR(2)) AS lief_pal_typ_id,
v05.bestellart_id,
v05.menge_lief_ist_kolli
FROM (SELECT
v051.mandant_id,
v051.wup_id AS kunde_id   
,
v051.nb_id AS nb_id_kunde 
,

v051.dat_lief_soll,
v051.lagernummer_id,
v052.lagerort_id,
v051.lief_pal_typ_id,
v052.wup_id 
,
v052.nb_id  
,
v052.art_id,
v052.best_beleg_id,
v052.bestellart_id,

SUM(v052.menge_lief_ist_kolli) AS menge_lief_ist_kolli
FROM dbp_view.v_besch_lief_2 v051

INNER JOIN dbp_view.v_besch_lief_det_2 v052
ON v051.mandant_id = v052.mandant_id
AND v051.lief_beleg_id = v052.lief_beleg_id
AND v051.dat_lief_soll = v052.dat_lief_soll
AND v051.kj = v052.kj






GROUP BY v051.mandant_id
,v051.wup_id
,v051.nb_id
,v051.kunde_id
,v051.dat_lief_soll
,v051.lagernummer_id
,v052.lagerort_id
,v051.lief_pal_typ_id
,v052.wup_id   
,v052.nb_id    
,v052.art_id
,v052.best_beleg_id
,v052.bestellart_id
 
) v05

INNER JOIN dbp_view.v_art_wg_zu_per_2 v02
ON v05.mandant_id    = v02.mandant_id
AND v05.art_id        = v02.art_id
AND v02.arthiertyp_id = 2
AND v02.dat_bis       = TO_DATE('9999-12-31', 'YYYY-MM_2-DD')

INNER JOIN dbp_view.v_art_vorschlagswert_per_2 v03
ON v05.mandant_id = v03.mandant_id
AND v05.art_id     = v03.art_id
AND v05.dat_lief_soll BETWEEN v03.dat_von AND v03.dat_bis

INNER JOIN dbp_view.v_art_wup_status_per_2 v04
ON v05.mandant_id = v04.mandant_id
AND v05.kunde_id   = v04.wup_id
AND v02.art_id     = v04.art_id
AND v05.dat_lief_soll BETWEEN v04.dat_von AND v04.dat_bis

LEFT JOIN
(

SELECT
v01_1.mandant_id,
v01_1.wup_id,
v01_1.nb_id,
v01_1.mandant_id AS mandant_id_kunde,
v01_1.kunde_id,
v01_1.auslieferungsgruppe_id,
v01_1.terminierungsgruppe_1_id,
v01_1.terminierungsgruppe_2_id,
v01_1.terminierungsgruppe_3_id,
v01_1.disposition_rhythmus_ltf_id,
v01_1.wg_id,
v01_1.arthiertyp_id,
v01_1.dat_von,
v01_1.dat_bis
FROM dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per_2 v01_1
QUALIFY ROW_NUMBER() OVER (PARTITION BY v01_1.mandant_id
,v01_1.wup_id
,v01_1.nb_id
,v01_1.kunde_id
,v01_1.wg_id
,v01_1.arthiertyp_id
,v01_1.terminierungsgruppe_1_id
,v01_1.terminierungsgruppe_2_id
,v01_1.terminierungsgruppe_3_id
,v01_1.dat_bis
ORDER BY v01_1.sortimentslistenart_id DESC NULLS LAST) = 1
) v01
ON v05.mandant_id    = v01.mandant_id
AND v05.wup_id        = v01.wup_id  
AND v05.nb_id         = v01.nb_id   
AND v05.kunde_id      = v01.kunde_id
AND v02.wg_id         = v01.wg_id
AND v02.arthiertyp_id = v01.arthiertyp_id
AND v05.dat_lief_soll BETWEEN v01.dat_von AND v01.dat_bis



AND v04.terminierungsgruppe_1_id = v01.terminierungsgruppe_1_id
AND v04.terminierungsgruppe_2_id = v01.terminierungsgruppe_2_id
AND v04.terminierungsgruppe_3_id = v01.terminierungsgruppe_3_id

INNER JOIN dbp_view.v_wup_2 v06
   ON v06.mandant_id = v05.mandant_id
   AND v06.wup_id = CASE WHEN TRY_CAST(v05.kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(v05.kunde_id AS INTEGER) END
   AND ((v06.nb_id IN (2, 0, -111) AND v06.wup_id > 0) OR (v06.nb_id = -1 AND v06.wup_id = 0));