CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_ABZUG as
                    SELECT
                    mandant_id,
                    abzug_id,
                    abzug_bez
                    FROM dbp_view.v_ivs_l_abzug;