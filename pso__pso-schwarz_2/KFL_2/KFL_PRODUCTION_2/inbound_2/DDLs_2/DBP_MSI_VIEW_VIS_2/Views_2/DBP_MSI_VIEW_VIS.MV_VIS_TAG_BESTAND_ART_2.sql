CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_BESTAND_ART_2(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	BEZUGSWEG_ID,
	RELEVANT_FG,
	ARTHIERTYP_ID,
	ABT_ID,
	WG_ID,
	ART_ID,
	GJ,
	KJMO,
	KJWO,
	DAT,
	MENGE_FREI
) AS

   -- FAKT Artikelbestand (Fehlmengen) pro Tag_2 - Filiale/Abt_2/WG/Artikel_2
   -- 2011KW46 Initial (Abloesung mv_marktbestand...)
   -- 2011KW5x Anpassung Zuordung (Mandant_2)
   -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 																								AS wup_id
 , CASE WHEN v03.abt_id = 1 AND v01.bezugsweg_id = 1 THEN v01.bezugsweg_id + 3 ELSE bezugsweg_id END  				AS bezugsweg_id
 , v01.relevant_fg
 , v02.arthiertyp_id
 , v03.abt_id
 , v02.wg_id
 , v02.art_id
 , v04.gj
 , v04.kjmo
 , v04.kjwo
 , v04.dat
 , v01.menge_lgbest_erp_frei_bme  																					AS menge_frei
FROM dbp_view.v_marktbestand_erp_2 v01

JOIN dbp_view.v_art_wg_zu_per_2 v02
ON  v01.mandant_id = v02.mandant_id
AND v01.art_id = v02.art_id
AND v02.dat_bis = '9999-12-31'
AND v02.arthiertyp_id = 2

JOIN dbp_view.v_wg_per_2 v03
ON  v01.mandant_id = v03.mandant_id
AND v02.mandant_id = v03.mandant_id
AND v02.wg_id = v03.wg_id
AND v02.arthiertyp_id = v03.arthiertyp_id
AND v03.dat_bis = '9999-12-31'
AND v03.arthiertyp_id = 2

JOIN dbp_view.v_tag_2 v04
ON  v04.dat = v01.dat
AND v04.akt_tag <= 0
AND v04.akt_gj BETWEEN -1 AND 0

INNER JOIN dbp_view.v_wup_2 wup_2
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;