CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_NUTZUNG as
                                               SELECT
                                               nutzung_id,
                                               nutzung_bez,
                                               spr_id,
                                               mandant_id
                                               FROM dbp_view.v_ivs_l_nutzung
                                               WHERE spr_id = 22;