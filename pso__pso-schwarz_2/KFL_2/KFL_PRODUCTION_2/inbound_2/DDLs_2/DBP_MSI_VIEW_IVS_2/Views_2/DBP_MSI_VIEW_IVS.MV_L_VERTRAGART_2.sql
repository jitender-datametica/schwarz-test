CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_VERTRAGART_2 as
                              SELECT
                              vertragart_id,
                              vertragart_bez,
                              mandant_id,
                              spr_id
                              FROM dbp_view.v_ivs_l_vertragart_2
                              WHERE spr_id = 22;