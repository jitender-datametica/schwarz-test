CREATE OR REPLACE VIEW DBP_VIEW.V_GP_EWM AS 
    SELECT 
        mandant_id
        ,gp_ewm_id
        ,gp_ewm_id_num
        ,gp_ewm_typ_id
        ,gp_ewm_grp_id
        ,name_org_1
        ,name_org_2
        ,gp_ewm_guid


FROM DBP_DATA.gp_ewm ;