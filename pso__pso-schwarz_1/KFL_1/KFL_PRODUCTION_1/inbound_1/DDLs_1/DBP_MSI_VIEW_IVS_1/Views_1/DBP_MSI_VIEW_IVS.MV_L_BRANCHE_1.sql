CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_BRANCHE_1
                                         AS
                                            SELECT
                                            mandant_id,
                                            branche_id,
                                            branche_bez,
                                            spr_id
                                            FROM dbp_view.v_ivs_l_branche_1
                                            WHERE spr_id = 22;