CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_ART_WUP_ZU_PER_1
-- 13.08.2012 twie: die Listung zum Zeitpunkt der Lieferung (DAT - PLZ) ermitteln (PLZ = Planlieferzeit)
-- 19.09.2012 msch: Erweiterung Abfrage auf Listung um KDIS Kennzeichen
-- 29.11.2012 twie: kdis_plz als eigene Spalte angelegt
(
mandant_id
,wup_id
,nb_id
,dat
,art_id
,bezugsweg_id
,listung_id
,plz_listung_id
,vk_brutto
,kdis
,plz_kdis
,wrg_id

)
AS
   SELECT

   v01.mandant_id, v01.wup_id, v01.nb_id, t1.dat, v01.art_id, v01.bezugsweg_id, v01.listung_id, v03.listung_id AS plz_listung_id, v01.vk_brutto, v01.kdis, v03.kdis AS plz_kdis, v01.wrg_id

   FROM dbp_view.v_art_wup_zu_per_1   v01

   JOIN dbp_view.v_tag_1 t1_1
   ON t1.dat BETWEEN v01.dat_von AND v01.dat_bis

   --PLZ ermitteln (aktuellste pro Artikel_1 und Markt)
   JOIN
   dbp_view.v_art_wup_status_per_1 v02
   ON v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id
   AND v02.dat_bis = '9999-12-31'

   --Listung und KDIS zum Zeitpunkt dat - plz ermitteln
   JOIN
   dbp_view.v_art_wup_zu_per_1   v03
   ON v01.art_id = v03.art_id
   AND v01.mandant_id = v03.mandant_id
   AND v01.wup_id = v03.wup_id
   AND ( t1.dat - v02.planlieferzeit ) BETWEEN v03.dat_von AND v03.dat_bis;