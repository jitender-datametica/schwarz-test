CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ABT_1
(
mandant_id
, abt_id
)
AS
   SELECT
  mandant_id,
   abt_id

  FROM dbp_view.v_abt_1;