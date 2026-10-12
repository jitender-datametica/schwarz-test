CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ART_KREISTYP_GRUPPE_WUP_ZU_2
(
mandant_id
, wup_id
, nb_id
, art_id
, kreistyp_gruppe_id
)
AS
   SELECT
   mandant_id, wup_id, nb_id, art_id, kreistyp_gruppe_id

   FROM dbp_view.v_art_kreistyp_gruppe_wup_zu_2
   WHERE mandant_id = 1
   AND nb_id = 0;