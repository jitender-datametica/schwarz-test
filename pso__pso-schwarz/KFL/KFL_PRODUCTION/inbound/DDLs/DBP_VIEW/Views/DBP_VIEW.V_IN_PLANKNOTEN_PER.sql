CREATE OR REPLACE VIEW DBP_VIEW.V_IN_PLANKNOTEN_PER AS 
    SELECT 
        mandant_id
        ,plantyp_id
        ,plangruppe_id
        ,planknoten_id
        ,planknotenzaehler_int
        ,dat_von
        ,dat_bis
        ,co_leistungsart_arbeitsplan_id
        ,arbeitsplan_menge
        ,arbeitsplan_menge_einh_id


FROM DBP_DATA.IN_PLANKNOTEN_PER ;