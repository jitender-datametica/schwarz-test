CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_MWST_PER
(
dat_bis
,dat_von
,mandant_id
,mwst
,mwst_bez
,mwst_id
,sap_mwst_id
,spr_id
)
AS
   SELECT
  dat_bis, dat_von, mandant_id, mwst, mwst_bez, mwst_id, sap_mwst_id, spr_id
   FROM dbp_view.v_mwst_per;