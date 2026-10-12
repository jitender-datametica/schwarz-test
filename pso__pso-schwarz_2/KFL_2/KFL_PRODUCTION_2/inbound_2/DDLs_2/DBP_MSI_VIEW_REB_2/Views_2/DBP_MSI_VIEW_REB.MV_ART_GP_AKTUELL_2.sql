CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ART_GP_AKTUELL_2
(
mandant_id
, art_id
, akt_gp_id
)
AS
   SELECT
   mandant_id, art_id, gp_id

   FROM dbp_view.v_art_gp_zu_per_2
   WHERE dat_bis = '9999-12-31';