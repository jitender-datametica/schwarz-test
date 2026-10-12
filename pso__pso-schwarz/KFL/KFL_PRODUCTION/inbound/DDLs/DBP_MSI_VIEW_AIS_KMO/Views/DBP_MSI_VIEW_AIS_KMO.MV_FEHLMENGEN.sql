CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_FEHLMENGEN
-- 05.05.2015, -dbay-
-- Kleine Aenderung nach Ruecksprache mit Patrick Neubeck...die Bestellarten
-- UB2K sollen nicht mehr fuer KMO zur Anzeige gebracht werden! Einfacher 
-- Filter und gut ist!
(
mandant_id
, wup_id
, nb_id
, lagerort_id
, empfaenger_wup_id
, mandant_id_empfaenger
, empfaenger_nb_id
, art_id
, dat_lief_soll
, bestellart_id
, wrg_id
, lieferungskuerzung_fg
, diff_id
, menge_lief_soll_kolli
, menge_lief_ist_kolli
, ek_netto_bnk_soll
, ek_netto_bnk_ist
, vk_netto_lief_soll
, vk_netto_lief_ist
, kz_menge_lief_soll_kolli
, kz_menge_lief_ist_kolli
, kz_ek_netto_bnk_soll
, kz_ek_netto_bnk_ist
, kz_vk_netto_lief_soll
, kz_vk_netto_lief_ist
)
AS
   SELECT
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.lagerort_id,
   v01.empfaenger_wup_id,
   v01.mandant_id_empfaenger,
   v01.empfaenger_nb_id,
   v01.art_id,
   v01.dat_lief_soll,
   v01.bestellart_id,
   CASE WHEN v200.wrg_typ_id = 1 THEN v01.wrg_id ELSE 'EUR' END AS wrg_id,
   v01.kuerzung_fg AS lieferungskuerzung_fg,
   v01.diff_id,
   v01.menge_lief_soll_kolli,
   v01.menge_lief_ist_kolli,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CASE WHEN v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 0 THEN (v01.ek_netto_bnk_soll * v01.umrechnungskurs)
        WHEN v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 1 THEN (v01.ek_netto_bnk_soll * v01.umrechnungskurs_hist)
        ELSE v01.ek_netto_bnk_soll END AS ek_netto_bnk_soll,
   CASE WHEN v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 0 THEN (v01.ek_netto_bnk_ist * v01.umrechnungskurs)
        WHEN v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 1 THEN (v01.ek_netto_bnk_ist * v01.umrechnungskurs_hist)
        ELSE v01.ek_netto_bnk_ist END AS ek_netto_bnk_ist,
   CASE WHEN v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 0 THEN (v01.vk_netto_soll * v01.umrechnungskurs)
        WHEN v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 1 THEN (v01.vk_netto_soll * v01.umrechnungskurs_hist)
        ELSE v01.vk_netto_soll END AS vk_netto_lief_soll,
   CASE WHEN v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 0 THEN (v01.vk_netto_ist * v01.umrechnungskurs)
        WHEN v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 1 THEN (v01.vk_netto_ist * v01.umrechnungskurs_hist)
        ELSE v01.vk_netto_ist END AS vk_netto_lief_ist,
   v01.kuerz_menge_lief_soll_kolli AS kz_menge_lief_soll_kolli,
   v01.kuerz_menge_lief_ist_kolli AS kz_menge_lief_ist_kolli,
   v01.kuerz_ek_netto_bnk_soll AS kz_ek_netto_bnk_soll,
   v01.kuerz_ek_netto_bnk_ist AS kz_ek_netto_bnk_ist,
   v01.kuerz_vk_netto_soll AS kz_vk_netto_lief_soll,
   v01.kuerz_vk_netto_ist AS kz_vk_netto_lief_ist

  FROM dbp_view.v_besch_lief_fehlmengen v01
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200

   WHERE v01.mandant_id <> 1 AND
         v01.bestellart_id NOT IN ('UB2K')
      AND v01.dat_lief_soll <= '2024-02-29';