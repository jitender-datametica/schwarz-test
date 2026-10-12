CREATE OR REPLACE VIEW szd_fe_mstr_iotchargers.v_dim_charger_1 (charger_uuid_nr, charger_label_nr, public_display_name) AS
SELECT charger_uuid_nr,
 charger_label_nr,
 public_display_name
FROM szd_core.t_dim_charger_1
WHERE dwh_valid_fg;