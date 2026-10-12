CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WERBE_MEDIUM_SPR_ZU_2
(
mandant_id
, medien_kz
, spr_id
, werbe_medium_bez
)
AS
   SELECT
   mandant_id, medien_kz, spr_id, werbe_medium_bez

   FROM dbp_view.v_werbe_medium_spr_zu_2
   WHERE mandant_id = 1
   AND spr_id = 22;