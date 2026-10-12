CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_ART_WUP_LIST_ZU_2
-- 20170209: TTEZ1905: SPEC0018113 Initial fuer den Bericht Scanningquote
--                   View liefert Listung auf Ebene Markt, Artikel. Im Gegensatz zu mv_art_wup_zu_per_2 aber nur heutige Sicht, nicht historisiert
-- 20170221: TTEZ1905: Join auf die Tabelle "flw_kunde_vkorg_vw_zu_2" ist notwendig weil diese auch in mv_l_in_kunde_2 verwendet wird.
--     Maerkte deren Eroeffnungsdatum in der Zukunft liegen und deren VK_2- und VW-Zuordnung noch nicht erfolgt ist,
--      sind in der Tabelle flw_kunde_vkorg_vw_zu_2 noch nicht drin. In der Bericht Scanningquote erhaelt man verschiedene
--     Werte in Metriken wenn ein JOIN im Berichts-SQL auf mv_l_kunde gemacht wird um nach Regionscluster zu Filtern.
--     Dadurch wird z.B. Anzahl Kunden(mit Filter Mandant_2=1) ist ungleich Anzahl Kunden(mit Filter Alle DE-Regionen)
(
mandant_id
,wup_id
,nb_id
,art_id
,bezugsweg_id
,kdis
,listung_id
,listung_markt
,in_art_id
,in_art_nr
,in_kunde_id
)
AS

   SELECT
   v01.mandant_id, v01.wup_id, v01.nb_id, v01.art_id, v01.bezugsweg_id, v01.kdis, v01.listung_id, CASE WHEN v01.listung_id = 1
   THEN (CASE WHEN v01.bezugsweg_id = 1 THEN (CASE WHEN v01.KDIS = 0 THEN '1' ELSE '5' END)
   WHEN v01.bezugsweg_id = 4 THEN (CASE WHEN v01.KDIS = 0 THEN '4' ELSE '8' END)
   ELSE 'ausgelistet'
   END)
   ELSE 'ausgelistet'
   END AS listung_markt, v03.in_art_id, v03.in_art_nr, v04.flw_kunde_id as in_kunde_id

   FROM dbp_view.v_art_wup_zu_per_2 v01
   INNER JOIN dbp_msi_view_flw.mv_l_in_art_2 v03     -- MARA_2 + Retailartikel

   ON v01.art_id = v03.art_id
   AND v01.mandant_id = v03.mandant_id
   INNER JOIN dbp_view.v_flw_kunde_2 v04
   ON v01.wup_id = v04.wup_id
   AND v01.mandant_id = v04.mandant_id
   INNER JOIN
   (SELECT DISTINCT flw_kunde_id, mandant_id
   FROM dbp_view.v_flw_kunde_vkorg_vw_zu_2
   WHERE flw_vw_id IN (10,20,25)) v05
   ON v04.mandant_id = v05.mandant_id
   AND v04.flw_kunde_id = v05.flw_kunde_id

   WHERE
   -- nur aktuelle Sicht, keine Historisierung
   v01.dat_bis = '9999-12-31'

   AND v01.mandant_id in (1,2)

   -- 20100330 Filterung der IWT Betriebe
   AND v01.nb_id <> 99;