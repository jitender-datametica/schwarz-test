CREATE OR REPLACE VIEW szd_production_fe_mstr_iotchargers.v_dim_charger (charger_uuid_nr, charger_label_nr,
public_display_name) AS SELECT charger_uuid_nr,
 charger_label_nr,
 public_display_name
FROM szd_production_core.t_dim_charger
WHERE dwh_valid_fg;