CREATE OR REPLACE VIEW DBP_VIEW.V_L_QUELLSYSTEM AS 
    SELECT 
        mandant_id,
        quellsystem_id,
        quellsystem_bez
FROM DBP_DATA.L_QUELLSYSTEM ;