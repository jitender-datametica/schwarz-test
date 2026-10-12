CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_WUG_1
(
mandant_id
, arthiertyp_id
, wug_id
, wg_id
)
AS
   SELECT
   1, arthiertyp_id, wug_id, wg_id

   FROM dbp_view.v_wug_1
   WHERE mandant_id = 1
   AND arthiertyp_id = 2
;