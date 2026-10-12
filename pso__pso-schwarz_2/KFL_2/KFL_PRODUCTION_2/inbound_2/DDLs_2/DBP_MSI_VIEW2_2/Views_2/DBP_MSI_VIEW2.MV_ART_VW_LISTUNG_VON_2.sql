CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ART_VW_LISTUNG_VON_2
-- AP0009229 Ausbau vw_id - sschuecke 28.09.2016
(
art_id
, mandant_id
, dat_von
, dat_erst_listung
)
AS
   SELECT
   art_id, mandant_id, dat_von, dat_erst_listung
   FROM dbp_view.v_art_vw_listung_von_2
   WHERE mandant_id = 1;