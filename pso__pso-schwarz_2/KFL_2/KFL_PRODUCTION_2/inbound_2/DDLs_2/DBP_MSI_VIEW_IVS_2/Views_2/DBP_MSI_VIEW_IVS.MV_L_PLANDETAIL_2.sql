CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_PLANDETAIL_2 as
         SELECT
         plandetail_id,
         plantyp_id,
         mandant_id,
         plandetail_bez,
         spr_id,
         dat_extrakt
         FROM dbp_view.v_ivs_l_plandetail_2
         WHERE spr_id = 22;