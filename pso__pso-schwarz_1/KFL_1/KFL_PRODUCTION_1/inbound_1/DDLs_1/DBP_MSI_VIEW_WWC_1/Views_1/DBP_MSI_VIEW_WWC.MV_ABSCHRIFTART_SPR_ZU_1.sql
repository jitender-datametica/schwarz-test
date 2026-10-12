CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ABSCHRIFTART_SPR_ZU_1
(
abschriftart_id,
abschriftart_bez,
mandant_id,
spr_id
)
AS
   SELECT
  abschriftart_id,
   abschriftart_bez,
   mandant_id,
   spr_id
   FROM dbp_view.v_abschriftart_spr_zu_1
   WHERE mandant_id=1;