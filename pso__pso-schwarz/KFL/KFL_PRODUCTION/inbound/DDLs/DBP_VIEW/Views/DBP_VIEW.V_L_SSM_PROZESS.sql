CREATE OR REPLACE VIEW DBP_VIEW.V_L_SSM_PROZESS AS 
    SELECT 
        mandant_id,
        ssm_prozess_id,
        ssm_aufwand_typ_id,
        wup_abt_id,
        treiber_id,
        dat_von,
        dat_bis,
        ssm_prozess_bez,
        dayforce_xrefcode,
        dayforce_xrefcode_de,
        dayforce_minimal_mapping,
        oeffnung_laden_theken_fg,
        rundung_typ_kz

FROM DBP_DATA.L_SSM_PROZESS ;