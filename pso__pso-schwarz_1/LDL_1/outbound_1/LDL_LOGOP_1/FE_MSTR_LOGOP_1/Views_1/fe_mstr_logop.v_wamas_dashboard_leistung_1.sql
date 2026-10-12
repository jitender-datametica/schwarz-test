/*
====================================================================================================
Division		   |	Lidl
Solution		   |	Operational Logistics (LOGOP)
DB schema		   |	fe_mstr_logop
DB table/view	   |	v_wamas_dashboard_leistung_1
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wamas_dashboard_leistung_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), lagerzone_nr
OPTIONS(description='Lagerzone Nummer'), kommissionierer OPTIONS(description='picker'), ksnr
OPTIONS(description='picking list number. PK/FK'), ks_date OPTIONS(description='picking date'), zeit_1
OPTIONS(description='picking date and time'), hr_ss OPTIONS(description='hour in second'), lieferdatum
OPTIONS(description='delivery date'), anzahl_fertig_kolli OPTIONS(description='Number of picked collis based on LEISTP'),
kommissionierzeit_in_hour OPTIONS(description='Time on commission in hour format'), anzpickte
OPTIONS(description='Number of picked TE'), anzpickhandhe OPTIONS(description='Number of Hand picked HE'), sumanzpause
OPTIONS(description='the number of breaks'), pausenzeit_in_min OPTIONS(description='break time in min'), dwh_updated
OPTIONS(description='Last update of table')) AS SELECT LP.client_id,
 LP.wh_id,
 LP.lazid_laznr AS lagerzone_nr,
 LP.kommissionierer,
 LP.ksnr,
 LP.ks_date,
 LP.zeit_1,
 CONCAT(SUBSTR(SUBSTR(CAST(TIME(LP.zeit_1) AS STRING), 1, 8), 1, 2), ':00:00') AS hr_ss,
 VPLK.lieferdatum,
 LP.anzahl_fertig_kolli,
 LP.kommissionierzeit_in_hour,
 LP.anzpickte,
 LP.anzpickhandhe,
 LP.sumanzpause,
  LP.sumpausezeit / 60 AS pausenzeit_in_min,
 LP.dwh_updated
FROM ldl_logop_data.t_wamas_leistp_1 AS LP
 LEFT JOIN ldl_logop_data.t_wamas_vplk_1 AS VPLK ON LP.client_id = VPLK.client_id AND LP.wh_id = VPLK.wh_id AND LP.ksnr =
      VPLK.ksnr AND LP.lazid_laznr = VPLK.laznr AND CURRENT_DATE BETWEEN VPLK.dwh_valid_from AND VPLK.dwh_valid_to AND
  NOT VPLK.deleted_fg
WHERE LP.leistart = 'MIN15'
 AND CURRENT_DATE BETWEEN LP.dwh_valid_from AND LP.dwh_valid_to
 AND LP.sumistzeit <> 0
 AND NOT LP.deleted_fg;