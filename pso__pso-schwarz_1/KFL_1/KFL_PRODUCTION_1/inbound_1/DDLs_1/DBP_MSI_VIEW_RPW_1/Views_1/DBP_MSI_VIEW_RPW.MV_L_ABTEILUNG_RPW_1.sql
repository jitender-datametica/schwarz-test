CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_ABTEILUNG_RPW_1
             (
             mandant_id
             ,abteilung_id
             ,system_id
             )
             AS
                SELECT
                mandant_id,
                abteilung_id,
                7
                FROM dbp_view.v_l_abteilung_rpw_1
                WHERE mandant_id = 1;