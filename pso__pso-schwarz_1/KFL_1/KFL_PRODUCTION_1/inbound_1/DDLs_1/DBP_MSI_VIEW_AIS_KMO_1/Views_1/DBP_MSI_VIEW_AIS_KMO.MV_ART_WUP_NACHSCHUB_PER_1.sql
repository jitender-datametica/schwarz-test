CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ART_WUP_NACHSCHUB_PER_1 AS
SELECT
v01. mandant_id,
v01. art_id,
v01. wup_id,
v01. nb_id,
v01. menge_bestand_soll_max
,v02.sollbestand
,v02.min_sicherh_bestand
,v03.dat
FROM dbp_view.v_art_wup_nachschub_per_1 v01
JOIN dbp_view.v_art_wup_status_per_1 v02
ON v01.art_id = v02.art_id AND v01.mandant_id = v02.mandant_id AND v01.wup_id = v02.wup_id
JOIN  dbp_view.v_tag_1 v03
ON v03.dat BETWEEN v02.dat_von AND v02.dat_bis
AND v03.dat BETWEEN v01.dat_von AND v01.dat_bis
WHERE v03.akt_kj >= -3;