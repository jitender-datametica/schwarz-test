CREATE OR REPLACE VIEW DBP_VIEW.V_RPM_FIN_PLAN_2 AS 
    SELECT 
        fin_gruppe_hierarchie_id
        ,dat_start
        ,rpm_plantyp_id
        ,dat_von
        ,wrg_id
        ,mandant_id
        ,betrag
        ,dat_bis
FROM DBP_DATA.rpm_fin_plan_2 ;