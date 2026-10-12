CREATE OR REPLACE VIEW DBP_VIEW.V_ART_WUP_PRUEFUNG AS 
    SELECT 
        mandant_id,
        pruef_prozess_typ_kz,
        wup_id,
        nb_id,
        art_id,
        dat_erstellung,
        pruef_id,
        z_arbeitsgebiet_id,
        pruef_status_id,
        dat_pruefung
FROM DBP_DATA.ART_WUP_PRUEFUNG ;