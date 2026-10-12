CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_pickliststate_act AS
SELECT client_id,
 wawi_instanz_kzl,
 wh_nr,
 picklistno,
 orderarea,
 keycode,
 storeno,
 formdate,
 moddate,
 moduser,
 oldkeycode,
 scn,
 dwh_created,
 dwh_updated
FROM ldl_logop_data.t_wawi_pickliststate
WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND keycode = 6
 AND moddate >= CAST('2025-03-01 00:00:00' AS DATETIME)
 AND NOT deleted_fg;