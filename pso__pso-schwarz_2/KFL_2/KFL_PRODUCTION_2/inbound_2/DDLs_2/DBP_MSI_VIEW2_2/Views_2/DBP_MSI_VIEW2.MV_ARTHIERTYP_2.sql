CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTHIERTYP_2 (arthiertyp_id,arthiertyp_bez)
AS
   SELECT arthiertyp_id, arthiertyp_bez
   from dbp_view.v_arthiertyp_2 where arthiertyp_id=2;