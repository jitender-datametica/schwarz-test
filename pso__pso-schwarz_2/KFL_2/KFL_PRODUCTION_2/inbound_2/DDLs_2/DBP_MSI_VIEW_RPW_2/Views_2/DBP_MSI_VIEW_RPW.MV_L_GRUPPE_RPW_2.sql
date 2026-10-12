CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_GRUPPE_RPW_2
                            (
                            mandant_id
                            ,gruppe_id
                            ,abteilung_id
                            ,system_id
                            )
                            AS
                               SELECT
                               mandant_id,
                               gruppe_id,
                               abteilung_id,
                               7
                               FROM dbp_view.v_l_gruppe_rpw_2
                               WHERE mandant_id = 1;