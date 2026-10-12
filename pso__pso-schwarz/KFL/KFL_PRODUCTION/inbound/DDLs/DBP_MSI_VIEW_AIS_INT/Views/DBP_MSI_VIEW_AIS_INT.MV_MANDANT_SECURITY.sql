CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_MANDANT_SECURITY
(
mandant_id
, mandant_bez
, mandant_kbez
)
AS

   SELECT v01.mandant_id, v01.mandant_bez, v01.mandant_kbez

   FROM dbp_view.v_mandant AS v01;