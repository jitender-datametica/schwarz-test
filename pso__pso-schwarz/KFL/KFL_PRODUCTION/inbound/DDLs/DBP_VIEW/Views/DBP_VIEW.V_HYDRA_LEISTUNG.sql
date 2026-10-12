CREATE OR REPLACE VIEW DBP_VIEW.V_HYDRA_LEISTUNG AS 
    SELECT 
        mandant_id
        ,buchungskreis_id_hydra
        ,produktivitaetsschl_hydra
        ,lagernummer_id
        ,transport_gv_id
        ,belegart_id_hydra
        ,wg_verkett_lief
        ,dat
        ,menge_1
        ,dauer_1
        ,menge_2
        ,dauer_2
        ,menge_3
        ,dauer_3
        ,menge_4
        ,dauer_4
        ,abrechnung_fg
        ,personalteilbereich_id


FROM DBP_DATA.hydra_leistung ;