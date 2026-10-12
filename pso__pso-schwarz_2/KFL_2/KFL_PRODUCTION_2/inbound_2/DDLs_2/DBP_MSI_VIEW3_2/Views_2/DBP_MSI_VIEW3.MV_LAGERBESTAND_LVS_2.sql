CREATE OR REPLACE VIEW dbp_msi_view3.mv_lagerbestand_lvs_2
(
  art_id
, best_qualifikation_id
, dat
, dat_haltbarkeit
, lagernummer_id
, lagertyp_id
, lagerplatz_id
, lagerort_id
, lagerquant_id
, lief_beleg_id
, lief_beleg_pos_id
, mandant_id
, menge_lgbest_lvs_frei_bme
, menge_lgbest_lvs_ges_bme
, menge_lgbest_lvs_kolli
, menge_lgbest_lvs_off_trans_bme
, menge_lgbest_lvs_palette
, menge_lgbest_lvs_bme
, betrag_lgbest_lvs
, nb_id
, sond_best_id
, wup_id
, system_id
, vk_netto_lgbest_lvs
, letzter_we_markt_bestand
, lager_einheiten_typ
, gewicht_gesamt
, dat_letzte_bewegung
, dauer_bestand_tage
, volumen_kolli
, volumen_palette
, wrg_id
, wrg_typ_id
, kj_lief_beleg
)
AS
-- 05.12.2019 baranowska: AP0041558, SPEC0066698 kj_lief_beleg
-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_2 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

SELECT
  v01.art_id
, v01.best_qualifikation_id
, v01.dat
, v01.dat_haltbarkeit
, v01.lagernummer_id
, v01.lagertyp_id
, v01.lagerplatz_id
, v01.lagerort_id
, v01.lagerquant_id
, v01.lief_beleg_id
, v01.lief_beleg_pos_id
, v01.mandant_id
, v01.menge_lgbest_lvs_frei_bme
, v01.menge_lgbest_lvs_ges_bme
, v01.menge_lgbest_lvs_kolli
, v01.menge_lgbest_lvs_off_trans_bme
, v01.menge_lgbest_lvs_palette
, v01.menge_lgbest_lvs_auslager
, v01.betrag_lgbest_lvs * v02.ek_anzeige_fg AS betrag_lgbest_lvs
, v01.nb_id
, v01.sond_best_id
, v01.wup_id
, v01.system_id
, CASE  WHEN v05.wrg_typ_id = 0 THEN (v01.vk_netto_lgbest_lvs * v04.umrechnungskurs) ELSE v01.vk_netto_lgbest_lvs END AS vk_netto_lgbest_lvs
, v01.dat_haltbarkeit - ((v03.mhd_zeitraum * v03.lager_prozent / 100)+0.5)  AS letzter_we_markt_bestand
, v01.lager_einheiten_typ
, v01.gewicht_gesamt
, v01.dat_letzte_bewegung
, CURRENT_DATE - v01.dat_letzte_bewegung AS dauer_bestand_tage
, v01.volumen_kolli
, v01.volumen_palette
, v05.wrg_id
, v05.wrg_typ_id
, v01. kj_lief_beleg

FROM dbp_view.v_lagerbestand_lvs_2 v01

CROSS JOIN dbp_msi.akt_msi_user_ek_anzeige_zu_2 v02

JOIN dbp_view.v_art_2 v03
ON v01.art_id = v03.art_id
AND v01.mandant_id = v03.mandant_id

JOIN dbp_msi_view3.mv_kurs_2 v04
ON v01.wrg_id = v04.von_wrg_id

JOIN dbp_view.v_mandant_wrg_typ_zu_2 v05
ON v01.mandant_id = v05.mandant_id

JOIN dbp_msi_view3.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 v06
ON v05.wrg_typ_id = v06.wrg_typ_id;