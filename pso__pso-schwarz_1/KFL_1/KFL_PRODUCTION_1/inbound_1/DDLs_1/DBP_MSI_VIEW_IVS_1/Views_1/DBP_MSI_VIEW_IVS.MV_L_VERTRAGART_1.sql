CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_VERTRAGART_1 as
                              SELECT
                              vertragart_id,
                              vertragart_bez,
                              mandant_id,
                              spr_id
                              FROM dbp_view.v_ivs_l_vertragart_1
                              WHERE spr_id = 22;