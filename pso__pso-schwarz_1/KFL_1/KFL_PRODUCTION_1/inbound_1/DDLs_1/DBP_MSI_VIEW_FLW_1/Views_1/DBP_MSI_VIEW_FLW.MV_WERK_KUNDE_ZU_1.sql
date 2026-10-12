CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_WERK_KUNDE_ZU_1
-- 15.09.2017 twie: SPEC0026009 Zuordnung Werke und belieferte Maerkte (Kunden), nur fuer DE
--                            eigenes Attribut fuer Werk anlegen - Werk (Kundenzu) - da zwischen Werk und Kunde keine Beziehung angelegt werden darf
--                            Diese Stammdatenbeziehung wuerde in vielen Berichten greifen, statt beide Infos aus der Fakttabelle zu holen, was die Ergebnisse verfaelschen wuerde
-- 13.05.2019 pjan: AP0043250, SPEC0054321 including werk_nr 6911

(
werk_id
,mandant_id
,in_kunde_id
)
AS
   SELECT
   v04.werk_id, v04.mandant_id, v03.flw_kunde_id AS in_kunde_id

   FROM dbp_view.v_vz_wg_wup_zu_per_1  v01   --Zuorndung Werk - Kunde auf WG Ebene

   JOIN dbp_view.v_wup_1  v02   --zur Filterung auf relevante Maerkte

   ON v01.mandant_id = v02.mandant_id
   AND v01.wup_id = v02.wup_id
   AND v01.nb_id = v02.nb_id

   JOIN dbp_view.v_flw_kunde_1 v03   --Ermittlung in_kunde_id zur wup_id

   ON v02.wup_id = v03.wup_id
   AND v02.mandant_id = v03.mandant_id

   JOIN dbp_view.v_flw_werk_1 v04   --Ermittlung werk_id zur vz_wup_id

   ON CAST(v01.vz_wup_id AS CHAR(4)) = v04.werk_nr
   AND v01.mandant_id = v04.mandant_id

   JOIN dbp_view.v_tag_1 v05   --aktuelle Sicht auf geoeffnete Maerkte

   ON v05.akt_tag = 0

   WHERE
   v01.vz_wup_id IN (6912, 6916)    --Zuorndung gilt nur fuer diese beiden Werke (fuer 6921 + 6922 s.u.)
   AND v01.dat_bis = '9999-12-31'               --keine alten Zuordnungen
   -- Filtern auf geoeffnete, deutsche Maerkte
   AND v01.mandant_id = 1
   AND v01.nb_id = 0
   AND v02.getraenkemarkt_fg = 0
   AND v05.dat BETWEEN v02.dat_eroeffnung AND v02.dat_bis

   --Gruppierung auf Werk und Kunde, da Zuordung in Tabelle auf WG Ebene. Es genuegt aber ein Eintrag fuer eine_1 WG damit die Zuordnung gueltig ist
   GROUP BY 1,2,3


   UNION


   --Fuer Werke Heilbronn und Bad Heiligenstadt gibt es keine Zuordnung in der Tabelle, sie beliefern alle deutschen Maerkte
   --Deshalb Cross Join zwischen Werk und Kunde als Zuordnung ausgeben

   SELECT

   v01.werk_id, v01.mandant_id, v03.flw_kunde_id AS in_kunde_id

   FROM

   (SELECT
   werk_id, mandant_id
   FROM dbp_view.v_flw_werk_1
   WHERE werk_nr IN ('6921', '6922', '6911')
   ) v01
   CROSS JOIN dbp_view.v_wup_1  v02

   JOIN dbp_view.v_flw_kunde_1 v03   --Ermittlung in_kunde_id zur wup_id

   ON v02.wup_id = v03.wup_id
   AND v02.mandant_id = v03.mandant_id

   JOIN dbp_view.v_tag_1 v04   --aktuelle Sicht auf geoeffnete Maerkte

   ON v04.akt_tag = 0

   -- Filtern auf geoeffnete, deutsche Maerkte
   WHERE v02.mandant_id = 1
   AND v02.nb_id = 0
   AND v02.getraenkemarkt_fg = 0
   AND v04.dat BETWEEN v02.dat_eroeffnung AND v02.dat_bis;