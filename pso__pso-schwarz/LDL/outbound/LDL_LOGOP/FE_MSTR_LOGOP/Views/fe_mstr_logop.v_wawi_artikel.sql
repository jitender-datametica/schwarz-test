CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wawi_artikel (client_id
OPTIONS(description='Client id - calculated based on the country code'), artikelnr OPTIONS(description='Item nr'),
bez_lang OPTIONS(description='Item description - long'), bez_kurz OPTIONS(description='Item description - short'),
deutschtext OPTIONS(description='Item description - DE'), artgrupnr OPTIONS(description='Item group nr'), dwh_load_id
OPTIONS(description='Load id'), dwh_created OPTIONS(description='Record created at'), dwh_updated
OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'), dwh_valid_to
OPTIONS(description='Valid to date'), deleted_fg OPTIONS(description='Flag if record is deleted'))
OPTIONS(DESCRIPTION = `ARTIKEL - LOOKUP VIEW BASED ON T_WAWI_ARTIKEL`) AS SELECT client_id,
 artikelnr,
 bez_lang,
 bez_kurz,
 deutschtext,
 artgrupnr,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 dwh_valid_from,
 dwh_valid_to,
 deleted_fg
FROM ldl_logop_data.t_wawi_artikel
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND NOT deleted_fg;