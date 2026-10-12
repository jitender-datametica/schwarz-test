CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_MANDANT_2
( mandant_id
,mandant_bez
,mandant_kbez
)
AS
   SELECT mandant_id, mandant_bez, mandant_kbez
   FROM dbp_view.v_mandant_2;