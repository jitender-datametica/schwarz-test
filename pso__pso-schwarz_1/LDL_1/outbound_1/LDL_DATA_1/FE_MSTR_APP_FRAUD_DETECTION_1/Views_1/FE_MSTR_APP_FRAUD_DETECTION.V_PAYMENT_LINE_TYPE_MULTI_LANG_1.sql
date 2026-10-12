CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_payment_line_type_multi_lang_1 (country_org_sid
OPTIONS(description='The identifier for the organization country_1'), paym_line_type_cd
OPTIONS(description='The code identifying the subtype discriminator for payment lines. It distinguishes between incoming and outgoing payments, i.e. payments made by the customer and payments made to the customer.'),
lang_cd OPTIONS(description='The code identifying the language.'), paym_line_type_descr
OPTIONS(description='A textual description for the subtype discriminator for payment lines.'), dwh_created_tmsp
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated_tmsp
OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE SUBTYE DISCRIMINATORS FOR PAYMENT LINES. IT DISTINGUISHES BETWEEN INCOMING AND OUTGOING PAYMENTS, I.E. PAYMENTS MADE BY THE CUSTOMER AND PAYMENTS MADE TO THE CUSTOMER.`)
AS SELECT O.int_org_sid AS country_org_sid,
 MAIN.paym_line_type_cd,
 MAIN.lang_cd,
 MAIN.paym_line_type_descr,
 MAIN.dwh_created_tmsp,
 MAIN.dwh_updated_tmsp,
 MAIN.dwh_load_id,
 MAIN.dwh_node_cd
FROM ldl_data_core_rel.t_payment_line_type_1 AS MAIN
 INNER JOIN ldl_data_core_dim.t_dim_internal_organization_1 AS O ON MAIN.lang_cd = O.official_lang_cd
WHERE O.is_country_org_fg
 AND O.dwh_valid_fg;