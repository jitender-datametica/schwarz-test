CREATE OR REPLACE VIEW FE_MSTR_BCBI.V_TICKETS_COUNTRY_ALL_1 AS 
SELECT 
    v_tickets_country.country_ticket_id
    ,T_COUNTRY.client_id
    ,T_COUNTRY.country_iso
    ,T_COUNTRY.COUNTRY_NAME
    ,T_COUNTRY.Country_cluster_id
    ,T_COUNTRY.Country_cluster_name
    ,v_tickets_country.opened_by_group
    ,v_tickets_country.country_flag_img
    ,v_tickets_country.country_flag_img_name
FROM FE_MSTR_BCBI.v_tickets_country_1 
LEFT JOIN FE_MSTR_BCBI.T_COUNTRY_1
ON v_tickets_country.country_name = T_COUNTRY.country_name;