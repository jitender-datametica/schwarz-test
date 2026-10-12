CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ARTHIERTYP_2 (arthiertyp_id, arthiertyp_bez)
AS
   SELECT arthiertyp_id, arthiertyp_bez FROM dbp_view.v_arthiertyp_2 WHERE arthiertyp_id=2;