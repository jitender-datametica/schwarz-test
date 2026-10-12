CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_BRANCHE
                                         AS
                                            SELECT
                                            mandant_id,
                                            branche_id,
                                            branche_bez,
                                            spr_id
                                            FROM dbp_view.v_ivs_l_branche
                                            WHERE spr_id = 22;