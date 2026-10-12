CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_WUG_SPR_ZU
(
mandant_id
, wug_id
, arthiertyp_id
, wg_id
, spr_id
, wug_bez
, wug_id_bez
)
AS
   SELECT
   mandant_id, wug_id, arthiertyp_id, wg_id, spr_id, wug_bez, CAST( CAST(wug_id AS CHAR(10)) || '   ' || wug_bez AS CHAR(50))

   FROM dbp_view.v_wug_spr_zu
   WHERE spr_id = 22
   AND mandant_id = 1
   AND arthiertyp_id = 2
;