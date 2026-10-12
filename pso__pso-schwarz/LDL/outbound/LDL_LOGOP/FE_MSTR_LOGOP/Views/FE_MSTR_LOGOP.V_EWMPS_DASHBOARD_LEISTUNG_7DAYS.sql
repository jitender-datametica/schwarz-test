CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_ewmps_dashboard_leistung_7days (client_id
OPTIONS(description='Client id - calculated based on the country code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), lagerzone_nr
OPTIONS(description='Lagerzone Nummer'), kommissionierer OPTIONS(description='picker'), ksnr
OPTIONS(description='picking list number. PK/FK'), ks_date OPTIONS(description='picking date'), hr_ss
OPTIONS(description='hour in second'), kommissionierzeit_in_hour
OPTIONS(description='Time on commission in hour format'), anzpickte OPTIONS(description='Number of picked TE'),
anzpickhandhe OPTIONS(description='Number of Hand picked HE'), sumanzpause OPTIONS(description='the number of breaks'),
pausenzeit_in_min OPTIONS(description='break time in min'), dwh_updated OPTIONS(description='Last update of table')) AS
SELECT client_id,
 wh_id,
 lazid_laznr AS lagerzone_nr,
 leistuser AS kommissionierer,
 ksnr,
 DATE(zeit) AS ks_date,
 CONCAT(SUBSTR(SUBSTR(CAST(TIME(zeit) AS STRING), 1, 8), 1, 2), ':00:00') AS hr_ss,
 SUM(sumistzeit / 3600) AS kommissionierzeit_in_hour,
 SUM(anzpickte) AS anzpickte,
 SUM(anzpickhandhe) AS anzpickhandhe,
 SUM(sumanzpause) AS sumanzpause,
 SUM(sumpausezeit / 60) AS pausenzeit_in_min,
 dwh_updated
FROM ldl_logop_data.t_ewmps_leistp AS LP
WHERE leistart = 'STD'
 AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND DATE(zeit) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY) AND (CURRENT_DATE)
 AND sumistzeit <> 0
 AND NOT deleted_fg
GROUP BY client_id,
 wh_id,
 lagerzone_nr,
 leistuser,
 ksnr,
 ks_date,
 hr_ss,
 dwh_updated;