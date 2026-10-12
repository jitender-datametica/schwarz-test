CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_MWST_PER_1
(
dat_von
,mwst_id
,mwst
,dat_bis
)
AS
   SELECT
  dat_von, mwst_id, mwst, dat_bis

   FROM dbp_view.v_mwst_per_1
   WHERE mandant_id = 1;