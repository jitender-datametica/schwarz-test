CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_AKTION_ART_WUP_JOIN_1_2
-- #616947 Werbewoche ist ab sofort flexibel, keine künstliche Woche_2 So-Sa mehr - sschuecke 20.05.2015
-- 'P0705 Erweiterung um Feld vk_vor_aktion_brutto - sschuecke 08.03.2016
-- Einschränkung auf 3 Kalenderjahre aus Performancegründen - sschuecke 01.12.2016
(
aktion_id
,mandant_id
,dat_von
,dat_bis
,dat
,kjwo
,vk_aktion_brutto
,vk_vor_aktion_brutto
,art_id
,wup_id
,nb_id
,vk_brutto
,aktionsart_id
,sap_werbe_kat_id
,preisaktivierung
,aktion_thema_id
,werbe_kat_id
)
AS
   SELECT
   v01.aktion_id, v01.mandant_id, v01.dat_von, v01.dat_bis, v03.dat, v03.kjwo, v02.vk_aktion_brutto, v02.vk_vor_aktion_brutto, v02.art_id, v02.wup_id, v02.nb_id, v06.vk_brutto, v01.aktionsart_id, v07.sap_werbe_kat_id, CASE WHEN v01.preisaktiviert_fg = 1 THEN 'x' ELSE ' ' END AS preisaktivierung, v02.aktion_thema_id, v07.werbe_kat_id

   FROM dbp_view.v_aktion_2   v01
   INNER JOIN dbp_view.v_aktion_art_wup_zu_2    v02
   ON  v02.aktion_id = v01.aktion_id
   AND v02.mandant_id = v01.mandant_id
   INNER JOIN dbp_view.v_tag_2 v03
   ON  v03.dat BETWEEN v01.dat_von AND v01.dat_bis
   INNER JOIN dbp_view.v_art_wup_zu_per_2 v06
   ON  v02.art_id = v06.art_id
   AND v02.mandant_id = v06.mandant_id
   AND v02.wup_id = v06.wup_id
   AND v02.nb_id = v06.nb_id
   AND v03.dat BETWEEN  v06.dat_von AND v06.dat_bis
   INNER JOIN dbp_view.v_l_werbekat_2 v07
   ON  v01.werbe_kat_id = v07.werbe_kat_id

   WHERE v02.grund_sperrung IS NULL
   AND v01.mandant_id = 1
   AND v03.akt_kj BETWEEN -3 AND 0;