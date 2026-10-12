CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ABSCHRIFTENART_1

(
abschriftenart_id
, abschriftenart_bez
, mandant_id
, spr_id
)
AS
   SELECT
   abschriftart_id, abschriftart_bez, mandant_id, spr_id

   FROM dbp_view.v_abschriftart_spr_zu_1
   WHERE mandant_id = 1
   AND abschriftart_id <> 90
;