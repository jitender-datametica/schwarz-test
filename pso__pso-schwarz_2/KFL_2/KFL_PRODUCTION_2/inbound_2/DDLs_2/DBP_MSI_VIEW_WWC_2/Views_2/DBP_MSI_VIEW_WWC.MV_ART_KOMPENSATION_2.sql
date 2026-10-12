CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_KOMPENSATION_2
-- AP0036938, SPEC0049514 - neue Attribute  der Artikel_2 Kompensation, Anbindung ZCGREFART
(
 mandant_id
,art_id
,MEINS
,ZCGREFART
,ZCGNR
,ZCGADV
,FACTOR
)
AS
   SELECT
    v01.mandant_id, v01.art_id, v01.komp_basismenge_einh_id AS MEINS, v01.art_id_ref              AS ZCGREFART, v02.komp_gruppe_id          AS ZCGNR, v02.komp_kriterium_fg       AS ZCGADV, v02.komp_faktor             AS FACTOR
   FROM dbp_view.v_art_kompensation_2 v01
   INNER JOIN dbp_view.v_art_kompensation_gruppe_zu_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id;