CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_BELEGART_GRUPPE_1
             (
             system_id
             ,mandant_id
             ,belegart_gruppe_id
             )
             AS
                SELECT
                7,
                mandant_id,
                belegart_gruppe_id
                FROM dbp_view.v_l_belegart_gruppe_1
                WHERE mandant_id = 1;