CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BESCH_LIEF_WUP_SUM_PALSPLIT
-- 13.06.2018 srom0404: NSR0211557 umwandeln nicht-numerisch auf numerisch jetzt mit TRYCAST
(
mandant_id
, wup_id
, nb_id
, lagerort_id
, dat_lief_soll
, lief_typ_id
--, vertr_beleg_typ_id
, kunde_id
, lief_pal_typ_id
--, werbeware_id
--, menge_lief_soll_bme
--, menge_lief_soll_kolli
--, betrag_lief_soll
--, menge_lief_ist_bme
, menge_lief_ist_kolli
--, betrag_lief_ist
--, menge_lief_fehl_bme
--, menge_lief_fehl_kolli
--, betrag_lief_fehl
, anzahl_position
, anzahl_packstueck
--, wrg_id
--, mandant_id_kunde
--, wrg_typ_id
--, vk_netto_lief_soll
--, vk_netto_lief_ist
--, vk_netto_lief_fehl
--, vol_ladung_liter

)

AS
   SELECT
  v01.mandant_id, v01.wup_id, v01.nb_id, v01.lagerort_id, v01.dat_lief_soll, v01.lief_typ_id, CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END kunde_id, v01.lief_pal_typ_id, v01.menge_lief_ist_kolli, v01.anzahl_position, v01.anzahl_packstueck
   /**
   , v03.wrg_id
   , CASE WHEN v01.mandant_id_kunde IS NULL OR v01.mandant_id_kunde = 0
   THEN v01.mandant_id
   ELSE v01.mandant_id_kunde
   END AS mandant_id_kunde
   , v03.wrg_typ_id
   , CASE WHEN v03.wrg_typ_id = 0
   THEN v01.vk_netto_lief_soll * v02.umrechnungskurs
   ELSE v01.vk_netto_lief_soll
   END AS vk_netto_lief_soll
   , CASE WHEN v03.wrg_typ_id = 0
   THEN v01.vk_netto_lief_ist * v02.umrechnungskurs
   ELSE v01.vk_netto_lief_ist
   END AS vk_netto_lief_ist
   , CASE
   WHEN v03.wrg_typ_id = 0
   THEN ((v01.vk_netto_lief_soll - v01.vk_netto_lief_ist) * v02.umrechnungskurs)
   ELSE (v01.vk_netto_lief_soll - v01.vk_netto_lief_ist)
   END AS vk_netto_lief_fehl
   , v01.vol_ladung_liter
   **/

   FROM
   dbp_view.v_besch_lief_wup_sum v01

   /**
   JOIN dbp_msi_view3.mv_kurs v02
   ON v01.wrg_id=v02.von_wrg_id

   JOIN dbp_view.v_mandant_wrg_typ_zu v03
   ON v01.mandant_id=v03.mandant_id

   JOIN dbp_msi.akt_msi_user_wrg_typ_zu v04
   ON v03.wrg_typ_id = v04.wrg_typ_id
   **/
   ;