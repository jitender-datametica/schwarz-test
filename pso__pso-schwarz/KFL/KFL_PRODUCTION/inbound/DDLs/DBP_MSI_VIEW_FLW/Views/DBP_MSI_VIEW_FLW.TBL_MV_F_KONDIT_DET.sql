CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_KONDIT_DET 
-- 26.10.2011 system_id entfernt
-- 31.01.2012 twie: preisliste_typ_id und in_vw_id eingefuegt
-- Filterung auf BSP und ABGN entfernt (jetzt im Frontend) dafuer betrag_kondition durchgereicht
-- 14.08.2013 twie: Retailartikel mit ausgeben
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
   mandant_id,
   kondition_id,
   konditionsart_id,
   in_art_id,
   dat_bis,
   dat_von,
   dat,
   wrg_id_org,
   preisliste_typ_id,
   in_vw_id,
   art_id,
   default_wrg,
   betrag_kondition,
   umrech_faktor
) AS
SELECT
           v01.mandant_id,
         v01.kondition_id,
         v01.konditionsart_id,
         v02.flw_art_id AS in_art_id,
         v02.dat_bis,
         v02.dat_von,
         t.dat,
         v02.wrg_id AS wrg_id_org -- als Zwischenwert zur besseren Analyse, wird nicht im FE angezeigt
,
         v02.preisliste_typ_id,
         v02.flw_vw_id AS in_vw_id,
         v04.art_id,
         v100.default_wrg,
         v01.betrag_kondition,
         v03.umrech_faktor
      FROM
         dbp_view.v_flw_kondit_det v01
         JOIN dbp_view.v_flw_kondit_freigabe v02 ON v01.mandant_id = v02.mandant_id
         AND v01.kondition_id = v02.kondition_id
         AND v01.konditionsart_id = v02.konditionsart_id
         LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per v03 ON v02.mandant_id = v03.mandant_id
         AND v02.flw_art_id = v03.flw_art_id
         AND v01.kondition_menge_einh_id = v03.altnv_menge_einh_id
         LEFT OUTER JOIN dbp_view.v_flw_art v04 ON v02.flw_art_id = v04.flw_art_id
         AND v02.mandant_id = v04.mandant_id
         JOIN dbp_view.v_mandant v100 ON v01.mandant_id = v100.mandant_id
          JOIN dbp_view.v_tag t ON t.dat BETWEEN v02.dat_von
         AND v02.dat_bis
  ;