CREATE OR REPLACE VIEW DBP_VIEW.V_GP_KONDITIONSGRUPPE_SPR_ZU_1 AS 
    SELECT 
        mandant_id,
        gp_id,
        konditionsgruppe_id,
        spr_id,
        gp_konditionsgruppe_bez

FROM DBP_DATA.GP_KONDITIONSGRUPPE_SPR_ZU_1;