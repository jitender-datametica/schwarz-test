CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_PREISTYP
(
   preistyp_id
  ,mandant_id
  ,spr_id
  ,preistyp_bez
)
AS
   SELECT
      preistyp_id, mandant_id, spr_id, preistyp_bez
   FROM dbp_view.v_l_preistyp
   WHERE
     mandant_id=1
;