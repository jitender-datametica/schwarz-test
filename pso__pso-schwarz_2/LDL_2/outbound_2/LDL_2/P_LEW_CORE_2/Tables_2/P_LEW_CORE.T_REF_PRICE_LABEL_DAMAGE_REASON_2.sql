CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_price_label_damage_reason_2 (
price_label_damage_reason_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='A unique code for the electronic price shield damage reason.'),
price_label_damage_reason_descr STRING(250)
OPTIONS(description='A textual desciption for the electronic price shield damage reason.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the row was inserted.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the row was updated the last time.'),
PRIMARY KEY (price_label_damage_reason_id) NOT ENFORCED
)
OPTIONS(description='This reference table contains the list of possible defects (RMA - Return Material Authorization).             Currently coming from Solum and not available for Imagotag.             - Defektgrund schwache Batterie             - Defektgrund Display Defekt             - ESL Label außerhalb Empfangsreichweite             Source: Manually filled.');