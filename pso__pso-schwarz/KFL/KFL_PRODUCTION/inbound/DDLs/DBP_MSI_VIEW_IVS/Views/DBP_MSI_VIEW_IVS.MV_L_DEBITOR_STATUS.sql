CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_L_DEBITOR_STATUS
                  AS
                     SELECT
                     mandant_id,
                     debitor_status_id,
                     debitor_status_bez,
                     spr_id
                     FROM dbp_view.v_ivs_l_debitor_status
                     WHERE spr_id = 22;