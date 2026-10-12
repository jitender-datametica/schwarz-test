CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ARTHIERTYP (arthiertyp_id, arthiertyp_bez)
AS
   SELECT arthiertyp_id, arthiertyp_bez FROM dbp_view.v_arthiertyp WHERE arthiertyp_id=2;