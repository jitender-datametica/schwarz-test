CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_WG_SPR_ZU_1
(
wg_id
, spr_id
, arthiertyp_id
, mandant_id
, wg_bez
, wg_id_bez
)
AS
   SELECT
   wg_id, spr_id, arthiertyp_id, mandant_id, wg_bez, CASE WHEN wg_id < 10  THEN '00' || CAST(wg_id AS VARCHAR(3))
   WHEN wg_id < 100 THEN '0' || CAST(wg_id AS VARCHAR(3))
   ELSE CAST(wg_id AS VARCHAR(3)) END|| '  ' ||wg_bez

   FROM dbp_view.v_wg_spr_zu_1
   WHERE spr_id = 22
   AND arthiertyp_id = 2
   AND mandant_id = 1
   AND wg_id  >= -3
;