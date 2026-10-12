/*
====================================================================================================
Division		   |	Lidl
Solution		   |	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop.
DB table/view	|	v_wamas_dashboard_kommstand
====================================================================================================
*/


-- LDL_LOGOP_DEVELOPMENT.FE_MSTR_LOGOP.V_WAMAS_DASHBOARD_KOMMSTAND source


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wamas_dashboard_kommstand (client_id
OPTIONS(description='Client id - calculated based on the country code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), lagerzone_nr
OPTIONS(description='Lagerzone Nummer'), lagerzone_desc OPTIONS(description='Description of Lagerzone'), ksnr
OPTIONS(description='Commission number. PK/FK'), status OPTIONS(description='status of the commission'), kommissionierer
OPTIONS(description='Commission driver'), tour_mandant OPTIONS(description='Mandant'), tour
OPTIONS(description='Tour number'), lieferdatum OPTIONS(description='delivery date'), liefterm
OPTIONS(description='devliery date and time'), bereitdatum OPTIONS(description='date when a commission is ready'),
bereitzeit OPTIONS(description='time when a commission is ready'), bereitterm
OPTIONS(description='date and time when a picking is ready'), startdatum
OPTIONS(description='date when a commission is started'), startzeit
OPTIONS(description='time when a commission is started'), ksstartzeit
OPTIONS(description='to determine the delayed colli'), sollstartzeit
OPTIONS(description='the planned starting date and time of a picking acitivity'), enddatum
OPTIONS(description='date when a commission is over'), endzeit OPTIONS(description='time when a commission is over'),
bestellte_kolli OPTIONS(description='planned colli'), fertig_kolli OPTIONS(description='picked colli'), offene_kolli
OPTIONS(description='open colli - difference between planned and picked colli'), anzahl_kolli
OPTIONS(description='number of colli based on the status'), kolli_status OPTIONS(description='status of colli'),
dwh_updated OPTIONS(description='Last update of table'), current_datetime OPTIONS(description='current date and time'),
morgen_by_default OPTIONS(description='the next day'))
OPTIONS(DESCRIPTION = `THIS IS A VIEW FOR WAMAS DASHBOARD TO CALCULATE OPEN COLLI, PROPORTION OF READY COMMISSION, NUMBER OF BREAKS ETC.`)
AS WITH VPLP_OHNE_THM AS (SELECT client_id,
   wh_id,
   ksnr,
   lagerzone_nr
  FROM ldl_logop_data.t_wamas_vplp
  WHERE CAST(matid_artid_artnr AS FLOAT64) > 10
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND NOT deleted_fg
  GROUP BY client_id,
   wh_id,
   ksnr,
   lagerzone_nr) (SELECT VK.client_id,
   VK.wh_id,
   VK.laznr AS lagerzone_nr,
   LZ.lagerzone_desc,
   VK.ksnr,
   VK.status,
   VK.pickenduser AS kommissionierer,
   VK.tourid_mandant,
   VK.tourid_tour,
   VK.lieferdatum,
   VK.liefterm,
   VK.bereitdatum,
   VK.bereitzeit,
   VK.bereitterm,
   VK.startdatum,
   VK.startzeit,
   VK.ksstartzeit,
   VK.sollstartzeit,
   VK.enddatum,
   VK.endzeit,
   VK.sollhe AS bestellte_kolli,
   VK.isthe AS fertig_kolli,
    VK.sollhe - VK.isthe AS offene_kolli,
   IF(VK.status = 'FERTIG', VK.sollhe, IF(VK.isthe > VK.sollhe, VK.sollhe, VK.sollhe - VK.isthe)) AS anzahl_kolli,
   IF(VK.status = 'FERTIG', 'gepickt', IF(CURRENT_TIMESTAMP() <= SAFE_CAST(VK.bereitterm as TIMESTAMP
       ), 'verspätet', 'offen')) AS kolli_status,
   VK.dwh_updated,
   CURRENT_TIMESTAMP() AS current_datetime,
   DATETIME_ADD(CURRENT_TIMESTAMP(), INTERVAL 1 DAY) AS morgen_by_default
  FROM ldl_logop_data.t_wamas_vplk AS VK
   LEFT JOIN VPLP_OHNE_THM AS vp ON VK.client_id = vp.client_id AND VK.wh_id = vp.wh_id AND VK.laznr = vp.lagerzone_nr
      AND VK.ksnr = vp.ksnr AND CURRENT_DATE BETWEEN VK.dwh_valid_from AND VK.dwh_valid_to AND NOT VK.deleted_fg
   INNER JOIN ldl_logop_data.t_wamas_lazk AS LZ ON VK.client_id = LZ.client_id AND VK.wh_id = LZ.wh_id AND VK.laznr = LZ
          .lazid_laznr AND CURRENT_DATE BETWEEN LZ.dwh_valid_from AND LZ.dwh_valid_to AND LZ.lazid_laztyp IN ('KOM') AND
       CURRENT_DATE BETWEEN VK.dwh_valid_from AND VK.dwh_valid_to AND NOT LZ.deleted_fg AND NOT VK.deleted_fg);