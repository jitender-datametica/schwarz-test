CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LIEF_TYP_1 (lief_typ_id, mandant_id)
AS
   SELECT lief_typ_id, mandant_id FROM dbp_view.v_l_lief_typ_1;