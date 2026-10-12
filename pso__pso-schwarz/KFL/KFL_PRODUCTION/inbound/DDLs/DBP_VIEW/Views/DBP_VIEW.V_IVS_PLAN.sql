CREATE OR REPLACE VIEW DBP_VIEW.V_IVS_PLAN AS 
    SELECT 
        plandetail_id
        ,mandant_id
        ,plantyp_id
        ,plan_objekt_id
        ,kjmo
        ,plan_wert
        ,plan_wert_konz
        ,kostenstelle_id
        ,dat_extrakt
        ,wrg_id


FROM DBP_DATA.ivs_plan ;