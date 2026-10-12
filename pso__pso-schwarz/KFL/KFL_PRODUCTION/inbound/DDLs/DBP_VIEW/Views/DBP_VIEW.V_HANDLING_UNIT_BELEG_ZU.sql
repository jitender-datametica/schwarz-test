CREATE OR REPLACE VIEW DBP_VIEW.V_handling_unit_beleg_zu 
AS SELECT 
        mandant_id,
        quelle,
        log_guid,
        handling_unit_guid,
        beleg_guid,
        belegtyp_id,
        td_update,
        td_insert
FROM DBP_DATA.handling_unit_beleg_zu ;