CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_BQ_FINDUNG
(
mandant_id
, bq_findung_id
)
AS
   SELECT
   v01.mandant_id,
   v01.bq_findung_id
  FROM dbp_view.v_l_bq_findung v01;