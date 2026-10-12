CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_KOMPONENTE_ART_2
--- 03.01.2012 AL Erstellt analog mv_art_2 Artikel_2 mit einer Eingeschränkung auf die Komponenten
(
mandant_id
, komponente_art_id
, komponente_kl_art_id
, komponente_kl_art_id_lang
)
AS

   SELECT
   v01.mandant_id,
   v01.art_id            AS komponente_art_id,
   v01.kl_art_id       AS komponente_kl_art_id,
   TO_VARCHAR(v01.kl_art_id, 'FM00000000') komponente_kl_art_id_lang

   FROM dbp_view.v_art_2 v01


   WHERE v01.mandant_id <> 1 AND

   (mandant_id, art_id) IN (SELECT mandant_id,
   art_id FROM dbp_view.v_stueckliste_det_2);