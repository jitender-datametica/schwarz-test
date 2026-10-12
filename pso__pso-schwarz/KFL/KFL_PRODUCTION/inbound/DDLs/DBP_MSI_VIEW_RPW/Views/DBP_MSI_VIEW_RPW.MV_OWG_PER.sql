CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_OWG_PER
 (
 owg_id
 , arthiertyp_id
 , mandant_id
 , dat_von
 , dat_bis
 , hwg_id
 , system_id
 )
 AS
    SELECT
    owg_id,
    arthiertyp_id,
    mandant_id,
    dat_von,
    dat_bis,
    hwg_id,
    7
    FROM dbp_view.v_owg_per
    WHERE mandant_id = 1
    AND arthiertyp_id = 2
    AND dat_bis = '9999-12-31';