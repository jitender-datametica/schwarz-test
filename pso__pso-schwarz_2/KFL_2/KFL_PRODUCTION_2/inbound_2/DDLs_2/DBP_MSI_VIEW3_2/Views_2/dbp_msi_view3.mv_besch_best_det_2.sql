CREATE OR REPLACE VIEW dbp_msi_view3.mv_besch_best_det_2
--NSR0828595, mcie, 03/07/2019, added loesch_fg=0 in where clause
-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_2 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

(
art_id
, best_beleg_id
, best_beleg_pos_id
, best_preis_menge_einh_id
, best_basismenge_einh_id
, dat_aenderung
, dat_best_beleg
, endlief_fg
, lagerort_id
, loesch_fg
, mandant_id
, menge_best_bme
, menge_best_kolli
, menge_best_palette
, nb_id
, selbstabhol_fg
, wup_id
, filiale_id
, kunde_id
, bestellart_id
, gp_id
, lieferndeswerk
, lieferndeswerk_nb_id
, betrag_best
, wrg_id
, wrg_typ_id
, menge_block_bestand
, gp_teilsortiment_id
)
AS
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
, wup_id
, filiale_id
, kunde_id
, v01.bestellart_id
, v01.gp_id
, v01.lieferndeswerk
, v01.lieferndeswerk_nb_id
, CASE
WHEN v01.wrg_typ_id = 0
THEN (v01.betrag_best * v01.umrechnungskurs * v05.ek_anzeige_fg)
ELSE (v01.betrag_best * v05.ek_anzeige_fg)
END AS betrag_best
, v01.wrg_id
, v01.wrg_typ_id
, v01.menge_block_bestand
, v01.gp_teilsortiment_id

FROM dbp_msi_view3.tbl_mv_besch_best_det_2 v01

JOIN dbp_msi_view3.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 v06
ON v01.wrg_typ_id = v06.wrg_typ_id

CROSS JOIN dbp_msi.akt_msi_user_ek_anzeige_zu_2 v05

;