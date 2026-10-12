CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ABT (mandant_id, abt_id, arthiertyp_id)
AS
   SELECT mandant_id, abt_id, arthiertyp_id FROM dbp_view.v_abt
   WHERE arthiertyp_id=2;