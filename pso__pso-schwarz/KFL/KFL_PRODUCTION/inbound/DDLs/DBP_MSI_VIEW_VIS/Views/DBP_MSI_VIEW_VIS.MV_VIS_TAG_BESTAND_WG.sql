CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_BESTAND_WG (
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	BEZUGSWEG_ID,
	RELEVANT_FG,
	ARTHIERTYP_ID,
	ABT_ID,
	WG_ID,
	GJ,
	KJMO,
	KJWO,
	DAT,
	OFFEN,
	ANZ_ARTIKEL_BESTAND,
	ANZ_ARTIKEL_FEHLMENGEN,
	ANZ_ARTIKEL_NULLBESTAND,
	ANZ_ARTIKEL_MINUSBESTAND
) AS

   -- FAKT/AGGREGAT Bestand (Fehlmengen) pro Tag - Markt/Abt/WG
   -- 2011KW46 Initial (Abloesung mv_marktbestand...)
   -- 2011KW5x Mapping Bezugsweg + (temp) join wupcal
   -- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 v01.mandant_id
 , v01.nb_id
 , wup.aktuell_wup_id 																						                     AS wup_id
 , CASE WHEN v01.abt_id = 1 AND v01.bezugsweg_id = 1 THEN v01.bezugsweg_id + 3 ELSE bezugsweg_id END  		AS bezugsweg_id
 , v01.relevant_fg
 , v01.arthiertyp_id
 , v01.abt_id
 , v01.wg_id
 , v01.gj
 , v01.kjmo
 , v01.kjwo
 , v01.dat
 , v02.offen
 , v01.anz_artikel_bestand
 , v01.anz_artikel_fehlmengen
 , v01.anz_artikel_nullbestand
 , v01.anz_artikel_minusbestand
FROM dbp_msi_v_view.v_vis_tag_bestand_wg v01

INNER JOIN dbp_view.v_wupcal v02
ON v01.mandant_id = v02.mandant_id
AND v01.wup_id = v02.wup_id
AND v01.dat = v02.dat
AND v02.offen = 1

INNER JOIN dbp_view.v_wup wup
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;