CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_wawi_org_store_contact_2 (st_loc_sid, client_id,
dat_rec_start, dat_rec_end, zipcode, city, street, phone, zipcode_postbox, postbox, fax, modem, load_id) AS SELECT
 st_loc_sid,
 client_id,
 dat_rec_start,
 dat_rec_end,
 zipcode,
 city,
 street,
 phone,
 zipcode_postbox,
 postbox,
 fax,
 modem,
 load_id
FROM ldl_p_lew_core.t_wawi_org_store_contact_2;