CREATE OR REPLACE VIEW DBP_VIEW.V_AAD_PAYM_TYPE_SPR_ZU AS 
    SELECT 
        mandant_id,
        spr_id,
        kpos_zahlung_typ_id,
        kpos_zahlung_typ_bez,
        paym_type_name

FROM DBP_DATA.AAD_PAYM_TYPE_SPR_ZU ;