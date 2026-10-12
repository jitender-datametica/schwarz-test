CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ART_KREISTYP_GRUPPE_WUP_ZU

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

   FROM dbp_view.v_art_kreistyp_gruppe_wup_zu
   WHERE nb_id = 0;