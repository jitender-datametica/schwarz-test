create or replace view DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_BESCH_BEST_DET(
	ART_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	BEST_PREIS_MENGE_EINH_ID,
	BEST_MENGE_EINH_ID,
	DAT_AENDERUNG,
	DAT_BEST_BELEG,
	ENDLIEF_FG,
	LAGERORT_ID,
	LOESCH_FG,
	MANDANT_ID,
	MENGE_BEST_BME,
	MENGE_BEST_KOLLI,
	MENGE_BEST_PALETTE,
	NB_ID,
	SELBSTABHOL_FG,
	WUP_ID,
	FILIALE_ID,
	KUNDE_ID,
	BESTELLART_ID,
	GP_ID,
	LIEFERNDESWERK,
	LIEFERNDESWERK_NB_ID,
	WRG_ID,
	WRG_TYP_ID,
	MENGE_BLOCK_BESTAND,
	GP_TEILSORTIMENT_ID,
	BETRAG_BEST,
	UMRECHNUNGSKURS
) as


SELECT
v01.art_id
, v01.best_beleg_id
, v01.best_beleg_pos_id
, v01.best_preis_menge_einh_id
, v01.best_menge_einh_id
, v01.dat_aenderung
, v01.dat_best_beleg
, v01.endlief_fg
, v01.lagerort_id
, v01.loesch_fg
, v01.mandant_id
, v01.menge_best_bme
, v01.menge_best_kolli
, v01.menge_best_palette
, v01.nb_id
, v01.selbstabhol_fg
, CASE
WHEN v01.nb_id = -111
THEN v01.wup_id
ELSE 0
END AS wup_id





, CASE WHEN TRY_CAST(v01.wup_id AS INTEGER) = 0 THEN NULL ELSE v05.aktuell_wup_id END filiale_id
, CASE
WHEN CAST(SUBSTR(v01.kunde_id,7,4) AS INTEGER) IS NULL
THEN 0
ELSE CAST(SUBSTR(v01.kunde_id,7,4) AS INTEGER)
END AS kunde_id
, v02.bestellart_id
, v02.gp_id
, v02.wup_id AS lieferndeswerk
, v02.nb_id AS lieferndeswerk_nb_id
, v04.wrg_id
, v04.wrg_typ_id
, v01.menge_block_bestand
, v01.gp_teilsortiment_id
, v01.betrag_best
, v03.umrechnungskurs

FROM dbp_view.v_besch_best_det v01

INNER JOIN dbp_view.v_wup v05
   ON v05.mandant_id = v01.mandant_id
   AND v05.wup_id = CASE WHEN TRY_CAST(v01.wup_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(v01.wup_id AS INTEGER) END
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

JOIN dbp_view.v_besch_best v02
ON v01.best_beleg_id = v02.best_beleg_id
AND v01.mandant_id = v02.mandant_id
AND v01.dat_best_beleg = v02.dat_best_beleg

JOIN DBP_MSI_VIEW3_MATERIALIZED.mv_kurs v03
ON v01.wrg_id=v03.von_wrg_id

JOIN dbp_view.v_mandant_wrg_typ_zu v04
ON v01.mandant_id=v04.mandant_id

WHERE v02.einkaufsorganisation_id <> 5000 
  AND v02.loesch_fg = 0 
  AND v01.loesch_fg = 0
  AND EXTRACT(YEAR FROM v01.dat_best_beleg) >= YEAR(CURRENT_TIMESTAMP) - 2;