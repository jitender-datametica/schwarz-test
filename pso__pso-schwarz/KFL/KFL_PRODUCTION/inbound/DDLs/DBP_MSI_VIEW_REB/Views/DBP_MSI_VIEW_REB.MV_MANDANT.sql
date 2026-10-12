CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_MANDANT
(
mandant_id
, mandant_bez
, mandant_kbez
)
AS
   SELECT
   mandant_id, mandant_bez, mandant_kbez

   FROM dbp_view.v_mandant
   WHERE mandant_id = 1;