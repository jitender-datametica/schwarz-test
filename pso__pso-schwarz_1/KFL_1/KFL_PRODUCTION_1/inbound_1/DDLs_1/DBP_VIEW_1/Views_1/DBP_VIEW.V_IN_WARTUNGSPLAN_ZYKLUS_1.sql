CREATE OR REPLACE VIEW DBP_VIEW.V_IN_WARTUNGSPLAN_ZYKLUS_1 AS 
    SELECT 
        mandant_id
        ,wart_plan_id
        ,wart_plan_zaehler
        ,zyklus_wert_sek
        ,zyklus_einh_id
        ,zyklus_wert


FROM DBP_DATA.IN_WARTUNGSPLAN_ZYKLUS_1 ;