CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESCH_BEST_LIEF_LBS
(
mandant_id
, best_beleg_id
, best_beleg_pos_id
, dat_buch
, endlief_fg
, best_menge_orig_fg
, annahmeverweigerung_id
, nb_id
, art_id
, gp_id
, wup_id
, lagerort_id
, bestellart_id
, dat_best_beleg
, dat_lief_wunsch
, dat_lief_bewertung
, menge_lief
, betrag_lagerbew_ek_n
, betrag_best_ek_n
, menge_best_bme
, fehllieferung_kz
, menge_lagerbew_kolli
, menge_best_kolli
, betrag_fehlmenge_vk_brutto
, wrg_id
, wrg_typ_id
, spaet_lief_tage
, prozent_akzeptanz_unterlief
)
AS
-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

SELECT
v01.mandant_id
, v01.best_beleg_id
, v01.best_beleg_pos_id
, v01.dat_buch
, v01.endlief_fg
, v01.best_menge_orig_fg
, v01.annahmeverweigerung_id
, v01.nb_id
, v01.art_id
, v01.gp_id
, v01.wup_id
, v01.lagerort_id
, v01.bestellart_id
, v01.dat_best_beleg
, v01.dat_lief_wunsch
, v01.dat_lief_bewertung
, v01.menge_lief
, v01.betrag_lagerbew_ek_n
, v01.betrag_best_ek_n
, v01.menge_best_bme
, v01.fehllieferung_kz
, v01.menge_lief_ist_kolli AS menge_lagerbew_kolli
, v01.menge_lief_soll_kolli AS menge_best_kolli
, v01.betrag_fehlmenge_vk_brutto
, v04.wrg_id
, v04.wrg_typ_id
, v02.spaet_lief_tage
, v06.prozent_akzeptanz_unterlief

FROM dbp_view.v_besch_best_lief_lbs v01
JOIN dbp_msi_view3.mv_mandant v02
ON v01.mandant_id = v02.mandant_id

JOIN dbp_msi_view3.mv_kurs v03
ON v01.wrg_id=v03.von_wrg_id

JOIN dbp_view.v_mandant_wrg_typ_zu v04
ON v01.mandant_id=v04.mandant_id

JOIN dbp_msi_view3.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU v07
ON v04.wrg_typ_id = v07.wrg_typ_id

CROSS JOIN dbp_msi.akt_msi_user_ek_anzeige_zu v05

JOIN dbp_view.v_ek_infosatz_wup_zu v06
ON v01.mandant_id = v06.mandant_id
AND v01.wup_id = v06.wup_id;