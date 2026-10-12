CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_FLAECHE_TYP_1 as
   SELECT
   flaeche_typ_id,
   spr_id,
   mandant_id,
   flaeche_typ_bez
   FROM dbp_view.v_ivs_l_flaeche_typ_1
   WHERE spr_id = 22;