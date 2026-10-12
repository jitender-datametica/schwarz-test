CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_BESCH_BESTELLARTEN
   -- Neuanlage mit Basis Aggregat besch_lief_best_lbs - sschuecke 04.08.2014
-- AP0025322, SPEC0037428 Erweiterung um anforderername aus besch_best_det  - mkub1811 07.05.2018
      (
mandant_id
,best_beleg_id
,best_beleg_pos_id
,art_id
,wup_id
,nb_id
,lagerort_id
,loesch_fg
,menge_best_bme
,menge_best_kolli
,menge_best
,dat_best_beleg
,betrag_pos_netto_best_wrg
,wrg_id
,gp_id
,bestellart_id
,dat_buch
,dat_lief_wunsch
,dat_lief_bewertung
,betrag_ekn
,wewa_menge
,wewa_betrag
,anforderer_name
)
AS 
   SELECT
   mandant_id,
   best_beleg_id,
   best_beleg_pos_id,
   art_id,
   wup_id,
   nb_id,
   lagerort_id,
   loesch_fg_ekpo AS loesch_fg,
   MAX(menge_best_bme) AS menge_best_bme,
   MAX(menge_best_kolli) AS menge_best_kolli,
   SUM(menge_best) AS menge_best,
   dat_best_beleg,
   MAX(betrag_pos_netto_best_wrg) AS betrag_pos_netto_best_wrg,
   wrg_id,
   gp_id,
   bestellart_id,
   MAX(dat_buch),
   dat_lief_wunsch,
   dat_lief_bewertung,
   MAX(betrag_ekn) AS betrag_ekn,
   SUM(menge_lief_ist_kolli) AS wewa_menge,
   SUM(wewa_betrag) AS wewa_betrag,
   anforderer_name

   FROM (
   SELECT
   t1.mandant_id,
   t1.best_beleg_id,
   t1.best_beleg_pos_id,
   t1.art_id,
   t1.wup_id,
   t1.nb_id,
   t1.lagerort_id,
   t1.loesch_fg_ekpo,
   menge_best_bme,
   menge_best_kolli,
   menge_best,
   t1.dat_best_beleg,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CAST(CASE WHEN t2.wrg_typ_id  = 1 THEN t1.betrag_best_ek_n
             WHEN t2.wrg_typ_id  = 0 AND t2.berichtskurs_typ_id = 0 THEN t1.betrag_best_ek_n* t1.umrechnungskurs_akt
             WHEN t2.wrg_typ_id  = 0 AND t2.berichtskurs_typ_id = 1 THEN t1.betrag_best_ek_n* t1.umrechnungskurs_hist
             END AS DECIMAL(18,6))   AS betrag_best_ek_netto,
   CASE WHEN t1.endlief_fg = 1 THEN betrag_best_ek_netto *-1 ELSE betrag_best_ek_netto END AS betrag_pos_netto_best_wrg,
   t1.wrg_id,
   t1.gp_id,
   t1.bestellart_id,
   t1.lager_bewart_id,
   dat_buch,
   t1.endlief_fg,
   t1.dat_lief_wunsch,
   t1.dat_lief_bewertung,
   CAST(CASE WHEN t2.wrg_typ_id  = 1 THEN t1.betrag_lagerbew_ek_n 
             WHEN t2.wrg_typ_id  = 0 AND t2.berichtskurs_typ_id = 0 THEN t1.betrag_lagerbew_ek_n* t1.umrechnungskurs_akt
             WHEN t2.wrg_typ_id  = 0 AND t2.berichtskurs_typ_id = 1 THEN t1.betrag_lagerbew_ek_n* t1.umrechnungskurs_hist
             END AS DECIMAL(18,6))   AS betrag_ekn,
   t1.menge_lief_ist_kolli,
   CAST(CASE WHEN t2.wrg_typ_id  = 1 THEN t1.betrag_lagerbew_ek_n
             WHEN t2.wrg_typ_id  = 0 AND t2.berichtskurs_typ_id = 0 THEN t1.betrag_lagerbew_ek_n* t1.umrechnungskurs_akt
             WHEN t2.wrg_typ_id  = 0 AND t2.berichtskurs_typ_id = 1 THEN t1.betrag_lagerbew_ek_n* t1.umrechnungskurs_hist
             END AS DECIMAL(18,6))   AS betrag_lagerbew_ek_netto,
   CASE WHEN  t1.lager_bewart_id IN (102, 161, 902) AND t1.nb_id IN (-111, 0) AND t1.endlief_fg = 1 THEN
   CASE WHEN  t1.lager_bewart_id IN (102, 161, 902) AND betrag_lagerbew_ek_netto = 0 THEN NULL ELSE betrag_lagerbew_ek_netto *-1 END

   WHEN  t1.lager_bewart_id IN (641, 647) AND t1.nb_id IN (-111, 0) AND t1.endlief_fg = 1 THEN
   CASE WHEN  t1.lager_bewart_id IN (101, 162, 901) AND betrag_lagerbew_ek_netto = 0 THEN NULL ELSE betrag_lagerbew_ek_netto END

   WHEN  t1.lager_bewart_id IN (101, 162, 901) AND t1.nb_id IN (-111, 0) AND t1.endlief_fg <> 1 THEN
   CASE WHEN  t1.lager_bewart_id IN (101, 162, 901) AND betrag_lagerbew_ek_netto = 0 THEN NULL ELSE betrag_lagerbew_ek_netto END

   WHEN  t1.lager_bewart_id IN (642, 648) AND t1.nb_id IN (-111, 0) AND t1.endlief_fg <> 1 THEN
   CASE WHEN  t1.lager_bewart_id IN (102, 161, 902) AND betrag_lagerbew_ek_netto = 0 THEN NULL ELSE betrag_lagerbew_ek_netto *-1 END

   END AS wewa_betrag,
   t1.anforderer_name
   FROM DBP_MSI_VIEW_AIS_KMO.TBL_MV_BESCH_BESTELLARTEN t1
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu t2) v01

 GROUP BY
   mandant_id
   ,best_beleg_id
   ,best_beleg_pos_id
   ,art_id
   ,wup_id
   ,nb_id
   ,lagerort_id
   ,loesch_fg
   ,dat_best_beleg
   ,wrg_id
   ,gp_id
   ,bestellart_id
   ,dat_lief_wunsch
   ,dat_lief_bewertung
   ,anforderer_name;