CREATE OR REPLACE VIEW DBP_VIEW.V_LAGERNUMMER_TOR_BSF_ZU AS 
    SELECT 
        mandant_id,
        lagernummer_id,
        wup_id,
        nb_id,
        tor_id,
        bsf_gruppe_id,
        bsf_id
        ,TD_UPDATE 
        ,TD_INSERT 
FROM DBP_DATA.lagernummer_tor_bsf_zu ;
