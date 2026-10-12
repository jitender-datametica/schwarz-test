CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ABSCHRIFTART_SPR_ZU_2
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
   FROM dbp_view.v_abschriftart_spr_zu_2
   WHERE mandant_id=1;