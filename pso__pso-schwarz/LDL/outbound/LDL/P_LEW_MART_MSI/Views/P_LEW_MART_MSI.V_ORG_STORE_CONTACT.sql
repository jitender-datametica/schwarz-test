CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_org_store_contact AS SELECT client_id,
 store_id,
 zipcode,
 city,
 street,
 postbox,
 phone,
 fax,
 zipcode_postbox,
 modem
FROM ldl_p_lew_mart_msi.t_org_store_contact AS LCNT;