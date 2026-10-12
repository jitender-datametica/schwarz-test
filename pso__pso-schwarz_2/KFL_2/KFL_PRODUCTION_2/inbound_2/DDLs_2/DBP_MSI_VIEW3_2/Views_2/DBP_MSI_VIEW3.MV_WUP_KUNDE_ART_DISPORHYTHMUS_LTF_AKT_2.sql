CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WUP_KUNDE_ART_DISPORHYTHMUS_LTF_AKT_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	MANDANT_ID_KUNDE,
	KUNDE_ID,
	ART_ID,
	WG_ID,
	ARTHIERTYP_ID,
	DISPOSITION_RHYTHMUS_LTF_ID,
	TERMINIERUNGSGRUPPE_1_ID,
	TERMINIERUNGSGRUPPE_2_ID,
	TERMINIERUNGSGRUPPE_3_ID,
	AUSLIEFERUNGSGRUPPE_ID,
	DISPONENT_ID,
	WG_VERKETT_ID,
	AUSG_MENGE_EINH_ID
) AS
-- 25.01.2018, AP0018098 - Disporhythmus, srom0404, initial
-- 16.03.2018, AP0018098 - Disporhythmus, srom0404, mandant_id_kunde
-- 20.02.2019, AP0018098 - Disporhythmus, nwag2310, Erweiterung Grundmenge um auf VZ-Markt-Artikel_2 Kombinationen anzuzeigen bei denen der Disporhythmus nicht bzw. falsch gepflegt ist
-- 25.02.2019, AP0018098, srom0404 - Disporhythmus, Erweiterung Grundmenge um auf VZ-Markt-Artikel_2 Kombinationen anzuzeigen bei denen der Disporhythmus nicht bzw. falsch gepflegt ist
--2024-07-24,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
   SELECT
   v02.mandant_id, 
   v02.wup_id AS wup_id,
   -111 AS nb_id, 
   v01.mandant_id AS mandant_id_kunde, 
   --v01.wup_id AS kunde_id,
   CASE WHEN TRY_CAST(v01.wup_id AS INTEGER) = 0 THEN NULL ELSE v02.aktuell_wup_id END AS kunde_id,
   v01.art_id,
   v03.wg_id,
   v03.arthiertyp_id,
   CAST(COALESCE(v04.disposition_rhythmus_ltf_id,'-1') AS CHAR(3)) AS disposition_rhythmus_ltf_id,
   v01.terminierungsgruppe_1_id,
   v01.terminierungsgruppe_2_id,
   v01.terminierungsgruppe_3_id,
   CAST(COALESCE(v04.auslieferungsgruppe_id,'-1') AS CHAR(4)) AS auslieferungsgruppe_id,
   v01.disponent_id,
   v01.wg_verkett_id,
   v05.ausg_menge_einh_id
  
  FROM dbp_view.v_art_wup_status_per_2 v01
     
   JOIN dbp_view.v_wup_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v02.wup_id = CASE WHEN TRY_CAST(v01.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(v01.wup_id AS INTEGER) END
   AND ((v02.nb_id IN (2, 0, -111) AND v02.wup_id > 0) OR (v02.nb_id = -1 AND v02.wup_id = 0))

   JOIN dbp_view.v_art_wg_zu_per_2 v03
   ON v01.mandant_id    = v03.mandant_id
   AND v01.art_id        = v03.art_id
   AND v03.arthiertyp_id = 2
   AND v03.dat_bis       = '9999-12-31'
   
   LEFT JOIN dbp_view.v_wup_kunde_art_disporhythmus_ltf_akt_2 v04
   ON v02.mandant_id = v04.mandant_id
   AND v01.art_id     = v04.art_id
   AND v01.wup_id     = v04.kunde_id
   AND v02.wup_id     = v04.wup_id

   JOIN dbp_view.v_art_vorschlagswert_per_2 v05
   ON v01.mandant_id = v05.mandant_id
   AND v01.art_id     = v05.art_id
   AND v05.dat_bis    = '9999-12-31'

   WHERE v01.dat_bis = '9999-12-31'
   AND v02.dat_bis  = '9999-12-31'
   AND v02.nb_id    = -111
   AND LEFT(v02.wup_standort,4) = 'VZ, ';