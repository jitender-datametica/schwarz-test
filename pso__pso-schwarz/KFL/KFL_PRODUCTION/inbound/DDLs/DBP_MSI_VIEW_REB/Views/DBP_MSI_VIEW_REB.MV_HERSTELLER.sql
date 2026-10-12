CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_HERSTELLER
(
herst_id
, herst_name
, mandant_id
, strasse
, plz
, ort
, land_id
, herst_fg
)
AS
   SELECT
   gp_id, gp_name, mandant_id, gp_strasse, gp_plz, gp_ort, land_id, herst_fg

   FROM dbp_view.v_gp
   WHERE mandant_id = 1
   AND herst_fg = 1
;