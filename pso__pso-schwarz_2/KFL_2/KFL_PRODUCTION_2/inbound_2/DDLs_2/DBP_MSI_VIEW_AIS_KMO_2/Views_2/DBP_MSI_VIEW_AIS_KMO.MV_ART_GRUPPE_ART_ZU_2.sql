CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ART_GRUPPE_ART_ZU_2

(
art_gruppe_id
,mandant_id
,art_id
,umrech_faktor


)
AS
   SELECT

   v01.art_gruppe_id,
   v01.mandant_id,
   v01.art_id,
   v01.umrech_faktor

   FROM dbp_view.v_art_gruppe_art_zu_2 v01
   WHERE mandant_id > 1
;