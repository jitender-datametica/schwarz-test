CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ABT

(
mandant_id
, abt_id
, arthiertyp_id
)
AS
   SELECT
   mandant_id, abt_id, arthiertyp_id

   FROM dbp_view.v_abt

   WHERE arthiertyp_id = 2
   AND mandant_id = 1
   AND abt_id BETWEEN -3 AND 8
;