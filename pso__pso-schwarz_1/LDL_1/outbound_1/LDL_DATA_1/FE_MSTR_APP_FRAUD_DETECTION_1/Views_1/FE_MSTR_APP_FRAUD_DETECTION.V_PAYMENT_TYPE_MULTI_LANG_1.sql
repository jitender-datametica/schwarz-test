CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_payment_type_multi_lang_1 (country_org_sid
OPTIONS(description='The identifier for the organization country_1'), paym_type_id
OPTIONS(description='The identifier for the way of payment, i.e. cash, card, voucher, etc.'), lang_cd
OPTIONS(description='The code identifying the language.'), paym_type_descr
OPTIONS(description='A textual description for the way of payment, i.e. cash, card, voucher, etc.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE WAY OF PAYMENT, I.E. CASH, CARD, VOUCHER, ETC.`) AS SELECT O.int_org_sid
  AS country_org_sid,
 MAIN.paym_type_id,
 MAIN.lang_cd,
 MAIN.paym_type_descr,
 MAIN.dwh_created_tmsp,
 MAIN.dwh_updated_tmsp,
 MAIN.dwh_load_id,
 MAIN.dwh_node_cd
FROM ldl_data_core_rel.t_payment_type_1 AS MAIN
 INNER JOIN ldl_data_core_dim.t_dim_internal_organization_1 AS O ON MAIN.lang_cd = O.official_lang_cd
WHERE O.is_country_org_fg
 AND O.dwh_valid_fg;