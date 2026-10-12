CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_WERBE_MEDIUM_1
(
mandant_id
, medien_kz
)
AS
   SELECT
   mandant_id, medien_kz

   FROM dbp_view.v_l_werbe_medium_1
   WHERE mandant_id = 1;