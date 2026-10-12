CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_org_store_contact_2 (client_id, store_id, zipcode, city, street, postbox,
phone, fax, zipcode_postbox, modem) AS SELECT *
FROM ldl_p_lew_mart_msi.v_org_store_contact_2;