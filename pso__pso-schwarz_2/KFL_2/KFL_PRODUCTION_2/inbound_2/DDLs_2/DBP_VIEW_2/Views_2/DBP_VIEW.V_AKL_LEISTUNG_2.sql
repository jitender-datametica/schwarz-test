CREATE OR REPLACE VIEW DBP_VIEW.V_AKL_LEISTUNG_2 AS 
    SELECT 
        mandant_id,
        lagernummer_id,
        wup_id,
        nb_id,
        dat,
        stunde,
        lagertyp_id,
        meldepunkt,
        warenbewegungstyp_id,
        lager_einheiten_typ,
        menge_lbs_lvs_palette,
        menge_lbs_lvs_kolli
        ,TD_UPDATE 
        ,TD_INSERT  
FROM DBP_DATA.AKL_LEISTUNG_2 ;
