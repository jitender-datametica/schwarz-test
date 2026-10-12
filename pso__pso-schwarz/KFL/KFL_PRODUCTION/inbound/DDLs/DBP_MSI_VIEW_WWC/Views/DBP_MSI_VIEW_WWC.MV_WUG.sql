CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WUG
-- AP0016264, WGI Elementprompt angelegt, hier mandant_kbez aufgenommen, damit einheitlich zu WG, HWG
(
mandant_id
,mandant_kbez
,PRDHA
,MATKL
,WUG_SAP
)
AS
   SELECT
   v01.mandant_id,
   v02.mandant_kbez,
   v01.wug_id AS PRDHA,
   v01.wg_id AS MATKL,
   CASE WHEN v01.wg_id < 0 THEN TO_VARCHAR(v01.wg_id, 'FM000')
   ELSE TO_VARCHAR(v01.wg_id, 'FM000') END ||
   CASE WHEN v01.wug_id < 0 THEN TO_VARCHAR(v01.wug_id, 'FM000')
   ELSE TO_VARCHAR(v01.wug_id, 'FM000') END AS WUG_SAP
   FROM dbp_view.v_wug v01
   INNER JOIN dbp_view.v_mandant v02
   ON v01.mandant_id = v02.mandant_id
   WHERE arthiertyp_id = 2;