CREATE OR REPLACE VIEW DBP_VIEW.V_lgnum_vstel_sortiment_zu AS 
    SELECT 
        mandant_id,
        lagernummer_id,
        versandstelle_id,
        lagersortiment_id,
        td_update,
        td_insert
FROM DBP_DATA.lgnum_vstel_sortiment_zu ;