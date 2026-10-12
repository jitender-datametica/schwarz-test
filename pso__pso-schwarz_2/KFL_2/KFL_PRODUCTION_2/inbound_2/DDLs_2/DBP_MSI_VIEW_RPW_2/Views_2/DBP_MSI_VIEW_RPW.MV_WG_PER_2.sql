CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_WG_PER_2
 (
 wg_id
 , arthiertyp_id
 , mandant_id
 , lead_mwst_id
 , dat_von
 , abt_id
 , dat_bis
 , system_id
 , owg_id
 )
 AS
    SELECT
    wg_id,
    arthiertyp_id,
    mandant_id,
    lead_mwst_id,
    dat_von,
    abt_id,
    dat_bis,
    7,
    owg_id
FROM dbp_view.v_wg_per_2
WHERE mandant_id = 1
AND arthiertyp_id = 2
AND abt_id NOT IN (0,-1,-2,-3)
AND dat_bis = '9999-12-31';