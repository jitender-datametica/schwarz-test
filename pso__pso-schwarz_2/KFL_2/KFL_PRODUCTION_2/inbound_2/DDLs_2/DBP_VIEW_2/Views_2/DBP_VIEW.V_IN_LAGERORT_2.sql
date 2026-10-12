CREATE OR REPLACE VIEW DBP_VIEW.V_IN_LAGERORT_2 AS 
    SELECT 
        mandant_id
        ,werk_id
        ,in_lagerort_id
        ,in_lagerort_bez


FROM DBP_DATA.in_lagerort_2 ;