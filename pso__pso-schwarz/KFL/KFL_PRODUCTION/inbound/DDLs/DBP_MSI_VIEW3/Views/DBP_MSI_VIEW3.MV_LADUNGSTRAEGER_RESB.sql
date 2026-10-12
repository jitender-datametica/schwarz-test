CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LADUNGSTRAEGER_RESB
(mandant_id
,reservierung_id
,reservierung_pos_id
,dat_von
,dat_bis
,dat
,erledigt_fg
,art_id
,wup_id
,nb_id
,dat_ausstellung
,anz_ladungstraeger
,lager_bewart_id
,dat_aenderung
,bewegung_erlaubt_fg
,spediteur_id
,vk_brutto
)
AS

   SELECT
   v01.mandant_id, v01.reservierung_id, v01.reservierung_pos_id, v01.dat_von, v01.dat_bis, v03.dat, v01.erledigt_fg, v01.art_id, v01.wup_id, v01.nb_id, v01.dat_ausstellung, v01.anz_ladungstraeger, v01.lager_bewart_id, v01.dat_aenderung, v01.bewegung_erlaubt_fg, v01.spediteur_id, v99.vk_brutto

   FROM dbp_view.v_ladungstraeger_resb v01
   LEFT OUTER JOIN
   (
   SELECT
   v02.mandant_id, v02.art_id, MAX(V02.vk_brutto) AS vk_brutto

   FROM dbp_view.v_art_pm_vw_zu_per v02

   WHERE  v02.dat_bis = '9999-12-31'
   AND  (v02.art_id / 100  IN (9840018,9840133,9840042,9840059,9802554)  )
   AND (
   (v02.mandant_id  = 1 AND preistyp_id = 0 AND pm_id IN (1,10) AND v02.vw_id IN (1,2,3)) OR
   (v02.mandant_id <> 1 AND preistyp_id = 0 AND pm_id IN (1,10) AND v02.vw_id IN (10,90))
   )
   GROUP BY 1,2
   ) v99
   ON     v01.mandant_id = v99.mandant_id
   AND  v01.art_id          = v99.art_id

   JOIN dbp_view.v_tag v03
   ON   v03.dat BETWEEN v01.dat_von AND  v01.dat_bis
   AND v03.akt_kj > -3
   AND v03.dat <= CURRENT_DATE
   WHERE extract(year from v03.dat) >= year(current_timestamp) - 2

   ;