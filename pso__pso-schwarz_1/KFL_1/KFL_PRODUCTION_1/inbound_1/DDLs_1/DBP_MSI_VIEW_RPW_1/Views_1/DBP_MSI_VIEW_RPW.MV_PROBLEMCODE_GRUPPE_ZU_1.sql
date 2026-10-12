CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_PROBLEMCODE_GRUPPE_ZU_1
             (
             system_id
             ,mandant_id
             ,problemgruppe_id
             ,problemcode_id
             )
             AS
                SELECT
                7,
                mandant_id,
                problemgruppe_id,
                problemcode_id
                FROM dbp_view.v_problemcode_gruppe_zu_1
                WHERE mandant_id = 1
 ;