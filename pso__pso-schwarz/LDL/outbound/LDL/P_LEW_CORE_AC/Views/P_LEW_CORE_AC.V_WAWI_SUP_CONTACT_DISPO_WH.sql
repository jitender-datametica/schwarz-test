CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_sup_contact_dispo_wh (client_id, wh_loc_sid, sup_sid, dat_rec_start,
dat_rec_end, dispo_info, fax, phone, name_cont_person, fax_contact_fg, load_id) AS SELECT client_id,
 wh_loc_sid,
 sup_sid,
 dat_rec_start,
 dat_rec_end,
 dispo_info,
 fax,
 phone,
 name_cont_person,
 fax_contact_fg,
 load_id
FROM ldl_p_lew_core.t_wawi_sup_contact_dispo_wh;