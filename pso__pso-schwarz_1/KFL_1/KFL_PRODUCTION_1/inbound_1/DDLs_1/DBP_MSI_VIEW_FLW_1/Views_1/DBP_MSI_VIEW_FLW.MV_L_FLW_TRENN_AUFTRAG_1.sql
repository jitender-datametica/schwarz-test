CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_TRENN_AUFTRAG_1
(
mandant_id
--,system_id
,auftrag_id
,werk_id
,auftrag_bez

)
AS
   SELECT mandant_id, auftrag_id, werk_id, auftrag_bez
   FROM dbp_view.v_flw_trenn_auftrag_1;