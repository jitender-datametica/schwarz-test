CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_NUTZUNG_2 as
                                               SELECT
                                               nutzung_id,
                                               nutzung_bez,
                                               spr_id,
                                               mandant_id
                                               FROM dbp_view.v_ivs_l_nutzung_2
                                               WHERE spr_id = 22;