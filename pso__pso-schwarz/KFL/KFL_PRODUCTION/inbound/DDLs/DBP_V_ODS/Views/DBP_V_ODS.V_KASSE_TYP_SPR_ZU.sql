CREATE OR REPLACE VIEW DBP_V_ODS.V_kasse_typ_spr_zu AS 
    SELECT 
        kasse_typ_id,
        spr_id,
        kasse_typ_bez,
        kasse_name_bez
FROM DBP_ODS.kasse_typ_spr_zu;