CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_MANDANT
( mandant_id
,mandant_bez
,mandant_kbez
)
AS
   SELECT mandant_id, mandant_bez, mandant_kbez
   FROM dbp_view.v_mandant;