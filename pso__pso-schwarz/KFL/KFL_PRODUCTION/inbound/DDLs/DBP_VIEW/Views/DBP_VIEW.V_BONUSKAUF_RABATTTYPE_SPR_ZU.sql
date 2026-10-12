CREATE OR REPLACE VIEW DBP_VIEW.V_BONUSKAUF_RABATTTYPE_SPR_ZU AS 
    SELECT 
        bonuskauf_rabatttype_id
        ,spr_id
        ,bonuskauf_rabatttype_bez


FROM DBP_DATA.bonuskauf_rabatttype_spr_zu ;