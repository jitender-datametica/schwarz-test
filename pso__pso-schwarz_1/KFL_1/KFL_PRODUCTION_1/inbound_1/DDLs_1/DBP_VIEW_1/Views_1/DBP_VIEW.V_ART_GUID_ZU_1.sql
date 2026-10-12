CREATE OR REPLACE VIEW DBP_VIEW.V_art_guid_zu_1 
AS SELECT 
        mandant_id,
        art_guid_c22,
        art_guid,
        art_id,
        td_update,
        td_insert
FROM DBP_DATA.art_guid_zu_1 ;