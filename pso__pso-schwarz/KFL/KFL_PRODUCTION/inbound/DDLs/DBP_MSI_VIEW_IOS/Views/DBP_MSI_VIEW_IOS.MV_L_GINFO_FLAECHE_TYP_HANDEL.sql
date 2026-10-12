CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_GINFO_FLAECHE_TYP_HANDEL as
   SELECT
   ginfo_flaeche_typ_id, mandant_id
   from dbp_view.v_l_ginfo_flaeche_typ
   where flaeche_quelle_id  = 3;