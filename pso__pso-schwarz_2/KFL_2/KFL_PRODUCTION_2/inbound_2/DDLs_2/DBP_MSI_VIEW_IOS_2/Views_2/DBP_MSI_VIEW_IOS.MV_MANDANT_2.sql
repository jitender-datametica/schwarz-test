CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_MANDANT_2
(
mandant_id
,mandant_bez
,mandant_kbez
,mandant_sap_id
,default_wrg
,mandant_sort_id

)
AS
   SELECT
  mandant_id, mandant_bez, case when mandant_id = 1 then 'DE' else mandant_kbez end mandant_kbez, mandant_sap_id, default_wrg, mandant_sort_id
   FROM dbp_view.v_mandant_2;