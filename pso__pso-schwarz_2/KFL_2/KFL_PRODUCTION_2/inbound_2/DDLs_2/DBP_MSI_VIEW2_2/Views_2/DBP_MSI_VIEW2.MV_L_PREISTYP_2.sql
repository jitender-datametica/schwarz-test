CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_PREISTYP_2
(
   preistyp_id
  ,mandant_id
  ,spr_id
  ,preistyp_bez
)
AS
   SELECT
      preistyp_id, mandant_id, spr_id, preistyp_bez
   FROM dbp_view.v_l_preistyp_2
   WHERE
     mandant_id=1
;