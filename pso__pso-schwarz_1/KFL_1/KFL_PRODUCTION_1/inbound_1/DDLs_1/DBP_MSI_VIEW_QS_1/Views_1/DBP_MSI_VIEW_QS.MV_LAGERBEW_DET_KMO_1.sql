CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_LAGERBEW_DET_KMO_1
(
  art_id
, auto_fg
, best_beleg_id
, best_beleg_pos_id
, betrag_belegfluss_wg_art
, betrag_verkauf
, betrag_verkauf_ist
, betrag_verkauf_ist_netto
, betrag_vk_netto
, betrag_vk_netto_vz
, bq_findung_id
, bw_vorgang_id
, dat_buch
, einkaufsorganisation_id
, empfaenger_id
, erfsngs_menge_einh_id
, gp_id
, gp_id_zl
, grund_id
, kj
, kunde_id
, lager_bewart_id
, lagerbew_beleg_id
, lagerbew_beleg_pos_id
, lagerbew_beleg_pos_storno_id
, lagerbew_beleg_storno_id
, lagerbew_beleg_storno_kj
, lagerort_id
, lagerplatz_id
, mandant_id
, mandant_id_empfaenger
, mandant_id_kunde
, menge_erf
, menge_lagerbew_bme
, menge_lagerbew_kolli
, menge_lagerbew_palette
, menge_lief
, menge_lieferschein
, nb_id
, soll_haben_kz
, system_id
, wrg_id
, wup_id
, betrag_verkauf_konz
)
AS
SELECT
  v01.art_id
, v01.auto_fg
, v01.best_beleg_id
, v01.best_beleg_pos_id
, v01.betrag_belegfluss_wg_art
, v01.betrag_verkauf
, v01.betrag_verkauf_ist
, v01.betrag_verkauf_ist_netto
, v01.betrag_vk_netto
, v01.betrag_vk_netto_vz
, v01.bq_findung_id
, v01.bw_vorgang_id
, v01.dat_buch
, v01.einkaufsorganisation_id
, v01.empfaenger_id
, v01.erfsngs_menge_einh_id
, v01.gp_id
, v01.gp_id_zl
, v01.grund_id
, v01.kj
, v01.kunde_id
, v01.lager_bewart_id
, v01.lagerbew_beleg_id
, v01.lagerbew_beleg_pos_id
, v01.lagerbew_beleg_pos_storno_id
, v01.lagerbew_beleg_storno_id
, v01.lagerbew_beleg_storno_kj
, v01.lagerort_id
, v01.lagerplatz_id
, v01.mandant_id
, v01.mandant_id_empfaenger
, v01.mandant_id_kunde
, v01.menge_erf
, v01.menge_lagerbew_bme
, v01.menge_lagerbew_kolli
, v01.menge_lagerbew_palette
, v01.menge_lief
, v01.menge_lieferschein
, v01.nb_id
, v01.soll_haben_kz
, v01.system_id
, v01.wrg_id
, v01.wup_id
, v01.betrag_verkauf * v02.umrechnungskurs AS betrag_verkauf_konz

FROM dbp_view.v_lagerbew_det_1 v01

JOIN dbp_view.v_kurs_1 v02
ON v01.wrg_id = v02.von_wrg_id
AND v02.kurstyp_id = 3
AND v02.dat_bis = '9999-12-31'
 
WHERE v01.mandant_id IN (2,3,5,6,7,8) AND v01.lager_bewart_id IN ('251','252');