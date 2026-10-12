CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTHIERTYP (arthiertyp_id,arthiertyp_bez)
AS
   SELECT arthiertyp_id, arthiertyp_bez
   from dbp_view.v_arthiertyp where arthiertyp_id=2;