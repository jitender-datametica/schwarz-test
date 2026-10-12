CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_LADUNGSTRAEGER_2
(
mandant_id
, lagernummer_id
, art_id
, wup_id
, nb_id
, anz_ladtraeger_max
, stellplatz_faktor
, zlv_ladhilf_fg
)
AS
   SELECT
  mandant_id, lagernummer_id, art_id, wup_id, nb_id, anz_ladtraeger_max, stellplatz_faktor, zlv_ladhilf_fg

   FROM dbp_view.v_art_lagernummer_zu_per_2
   WHERE zlv_ladhilf_fg = 1;