CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_ABZUG_1 as
                    SELECT
                    mandant_id,
                    abzug_id,
                    abzug_bez
                    FROM dbp_view.v_ivs_l_abzug_1;