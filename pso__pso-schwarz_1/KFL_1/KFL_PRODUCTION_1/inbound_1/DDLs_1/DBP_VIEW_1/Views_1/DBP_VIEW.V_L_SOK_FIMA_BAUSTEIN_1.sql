CREATE OR REPLACE VIEW DBP_VIEW.V_L_SOK_FIMA_BAUSTEIN_1 AS 
    SELECT 
        mandant_id,
        sok_fima_baustein_id,
        sok_fima_baustein_nr,
        sok_abteilung_id
FROM DBP_DATA.L_SOK_FIMA_BAUSTEIN_1 ;