CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_AKTIVITAET_TYP as
   SELECT
   mandant_id,
   aktivitaet_typ_id,
   aktivitaet_typ_bez,
   spr_id
   FROM dbp_view.v_ivs_l_aktivitaet_typ
   WHERE spr_id = 22;