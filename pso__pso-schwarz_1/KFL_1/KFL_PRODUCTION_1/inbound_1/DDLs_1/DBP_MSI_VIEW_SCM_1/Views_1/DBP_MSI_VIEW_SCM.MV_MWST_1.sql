CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_MWST_1(
	MWST_ID,
	MANDANT_ID,
	MWST,
	MWST_BEZ
) AS
--2024-09-05, AP0202707_SPEC0268776, dknop, initial   


   SELECT
   mwst_id, mandant_id, mwst, mwst_bez
   FROM dbp_view.v_mwst_per_1
   WHERE dat_bis = '9999-12-31';