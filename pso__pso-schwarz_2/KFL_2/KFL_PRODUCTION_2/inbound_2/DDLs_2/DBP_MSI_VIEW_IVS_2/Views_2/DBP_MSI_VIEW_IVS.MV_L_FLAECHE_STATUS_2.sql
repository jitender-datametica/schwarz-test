CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_FLAECHE_STATUS_2 as
                                SELECT
                                flaeche_status_id,
                                flaeche_status_bez,
                                spr_id,
                                mandant_id
                                FROM dbp_view.v_ivs_l_flaeche_status_2
                                WHERE spr_id = 22;