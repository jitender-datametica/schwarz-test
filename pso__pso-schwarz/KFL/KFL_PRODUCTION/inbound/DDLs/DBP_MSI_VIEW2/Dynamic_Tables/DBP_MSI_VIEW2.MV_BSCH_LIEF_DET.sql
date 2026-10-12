CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_BSCH_LIEF_DET
(
	MANDANT_ID,
	BSCH_ID,
	BSCH_POS_ID,
	DAT_LIEF,
	DAT,
	STATUS,
	ANNAHMEVERWEIGERUNG_ID,
	NB_ID,
	ART_ID,
	BELEG_GP_ID,
	WUP_ID,
	BESTELLART_ID,
	DAT_BEST,
	DAT_LIEF_WUNSCH,
	DAT_LIEF_BEWERTUNG,
	LIEF_MENGE,
	LIEFERWERT,
	BESTELLWERT,
	BEST_MENGE,
	MENGE_BEST_ORIG,
	MENGE_BEST_KOLLI_ORIG,
	LAGERORT_ID,
	GP_ID,
	LOESCH_FG_EKKO,
	LOESCH_FG_EKPO,
	SELBSTABHOL_FG,
	ANZAHL_LIEF,
	ANZAHL_LIEF_POS,
	LAGER_BEWART_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
v01.mandant_id, 
v01.best_beleg_id                        AS bsch_id, 
v01.best_beleg_pos_id                    AS bsch_pos_id, 
v01.dat_buch                             AS dat_lief, 
v01.dat_buch                             AS dat, 
v01.endlief_fg                           AS status, 
v01.annahmeverweigerung_id, 
v01.nb_id, 
v01.art_id, 
v01.gp_id                                AS beleg_gp_id, 
v01.wup_id, 
v01.bestellart_id, 
v01.dat_best_beleg                       AS dat_best, 
v01.dat_lief_wunsch, 
v01.dat_lief_bewertung, 
v01.menge_lief                           AS lief_menge, 
v01.betrag_lagerbew_ek_n                 AS lieferwert, 
v01.betrag_best_ek_n                     AS bestellwert, 
v01.menge_best_bme                       AS best_menge, 
v01.menge_best_bme * best_menge_orig_fg  AS menge_best_orig, 
v01.menge_lief_soll_kolli * best_menge_orig_fg AS menge_best_kolli_orig, 
v01.lagerort_id, 
v02.gp_id, 
v01.loesch_fg_ekko, 
v01.loesch_fg_ekpo, 
v01.selbstabhol_fg, 
v01.anzahl_lief, 
v01.anzahl_lief_pos, 
v01.lager_bewart_id

FROM dbp_view.v_besch_best_lief_lbs v01
INNER JOIN dbp_view.v_art_gp_zu_per v02
ON  v01.mandant_id  = v02.mandant_id
AND v01.art_id      = v02.art_id
AND v01.dat_buch BETWEEN v02.dat_von AND v02.dat_bis
WHERE v01.mandant_id=1
AND v01.nb_id <> 99;