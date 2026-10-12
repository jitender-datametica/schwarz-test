CREATE OR REPLACE VIEW DBP_VIEW.V_IN_PLAN_PLANKNOTEN_ZU_PER AS 
    SELECT 
        mandant_id
        ,plantyp_id
        ,plangruppe_id
        ,plangruppenzaehler
        ,planknoten_id
        ,planknotenzaehler_int
        ,planfolge_id
        ,dat_von
        ,dat_bis
        ,dat_gueltig_ab
        ,loesch_fg
        ,dat_anlage
        ,dat_aenderung


FROM DBP_DATA.IN_PLAN_PLANKNOTEN_ZU_PER ;