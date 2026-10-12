CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_MANDANT
-- nfis0811 190311: SPEC0045159 Umsetzung Moldau
(
mandant_id
, mandant_bez
,mandant_kbez
, mandant_sort_id
, default_wrg
)
AS
   SELECT
   v01.mandant_id, v01.mandant_bez, CASE WHEN v01.mandant_id = 1 THEN 'DE' ELSE v01.mandant_kbez END AS mandant_kbez, v01.mandant_sort_id, v01.default_wrg
   FROM dbp_view.v_mandant v01;