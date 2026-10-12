CREATE OR REPLACE VIEW DBP_VIEW.V_L_NACHHALTIGKEITSLOGO AS 
    SELECT 
        nachhaltigkeitslogo_id
        ,logo_kzstg
        ,nachhaltigkeitslogo_bez


FROM DBP_DATA.l_nachhaltigkeitslogo ;