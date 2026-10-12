CREATE OR REPLACE VIEW DBP_VIEW.V_IN_PLAN_2 AS 
    SELECT 
        mandant_id
        ,plantyp_id
        ,plangruppe_id
        ,plangruppenzaehler
        ,plangruppenzaehler_int
        ,werk_id
        ,arbeitsplan_bez


FROM DBP_DATA.IN_PLAN_2 ;