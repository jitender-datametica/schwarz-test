CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ABT_SPR_ZU_1
(
mandant_id
, abt_id
, arthiertyp_id
, spr_id
, abt_bez
)
AS
   SELECT
   mandant_id, abt_id, arthiertyp_id, spr_id, abt_bez

   FROM dbp_view.v_abt_spr_zu_1

   WHERE spr_id = 22
   AND arthiertyp_id = 2
   AND mandant_id = 1
   AND abt_id BETWEEN -3 AND 8;