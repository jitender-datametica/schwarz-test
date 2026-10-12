/*
====================================================================================================
Division		   |	Lidl
Solution		   |	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop.
DB table/view	|	v_wamas_dashboard_kommstand
====================================================================================================
*/


-- LDL_LOGOP_DEVELOPMENT.FE_MSTR_LOGOP.V_WAMAS_DASHBOARD_KOMMSTAND source
CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_WAMAS_DASHBOARD_KOMMSTAND(
	CLIENT_ID COMMENT 'Client id - calculated based on the country code',
	WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)',
	LAGERZONE_NR COMMENT 'Lagerzone Nummer',
	LAGERZONE_DESC COMMENT 'Description of Lagerzone',
	KSNR COMMENT 'Commission number. PK/FK',
	STATUS COMMENT 'status of the commission',
	KOMMISSIONIERER COMMENT 'Commission driver',
	TOUR_MANDANT COMMENT 'Mandant',
	TOUR COMMENT 'Tour number',
	LIEFERDATUM COMMENT 'delivery date',
	LIEFTERM COMMENT 'devliery date and time',
	BEREITDATUM COMMENT 'date when a commission is ready',
	BEREITZEIT COMMENT 'time when a commission is ready',
	BEREITTERM COMMENT 'date and time when a picking is ready',
	STARTDATUM COMMENT 'date when a commission is started',
	STARTZEIT COMMENT 'time when a commission is started',
	KSSTARTZEIT COMMENT 'to determine the delayed colli',
	SOLLSTARTZEIT COMMENT 'the planned starting date and time of a picking acitivity',
	ENDDATUM COMMENT 'date when a commission is over',
	ENDZEIT COMMENT 'time when a commission is over',
	BESTELLTE_KOLLI COMMENT 'planned colli',
	FERTIG_KOLLI COMMENT 'picked colli',
	OFFENE_KOLLI COMMENT 'open colli - difference between planned and picked colli',
	ANZAHL_KOLLI COMMENT 'number of colli based on the status',
	KOLLI_STATUS COMMENT 'status of colli',
	DWH_UPDATED COMMENT 'Last update of table',
	CURRENT_DATETIME COMMENT 'current date and time',
	MORGEN_BY_DEFAULT COMMENT 'the next day'
) COMMENT='This is a View for WAMAS Dashboard to calculate open colli, proportion of ready commission, number of breaks etc.'
 AS
WITH vplp_ohne_thm
AS (
SELECT 
	client_id
   ,wh_id
   ,ksnr
   ,lagerzone_nr
FROM "DATA".T_WAMAS_VPLP 
WHERE matid_artid_artnr > 10
AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
AND deleted_fg = FALSE
GROUP BY client_id, wh_id, ksnr,lagerzone_nr
)
SELECT 
	vk.client_id
   ,vk.wh_id
   ,vk.laznr AS lagerzone_nr
   ,lz.lagerzone_desc
   ,vk.ksnr
   ,vk.status 
   ,vk.pickenduser AS kommissionierer
   ,vk.tourid_mandant
   ,vk.tourid_tour
   ,vk.lieferdatum
   ,vk.liefterm
   ,vk.bereitdatum
   ,vk.bereitzeit
   ,vk.bereitterm
   ,vk.startdatum
   ,vk.startzeit
   ,vk.ksstartzeit
   ,vk.sollstartzeit
   ,vk.enddatum
   ,vk.endzeit 
   ,vk.sollhe AS bestellte_kolli
   ,vk.isthe AS fertig_kolli
   ,vk.sollhe - vk.isthe AS offene_kolli
   ,IFF(vk.status = 'FERTIG',vk.sollhe
   ,IFF(vk.isthe > vk.sollhe,vk.sollhe,offene_kolli)) AS anzahl_kolli
   ,IFF(vk.status = 'FERTIG','gepickt'
   ,IFF(CURRENT_TIMESTAMP(0)<=vk.bereitterm,'verspätet','offen')) AS kolli_status
   ,vk.dwh_updated
   ,CURRENT_TIMESTAMP(0) AS current_datetime
   ,TIMESTAMPADD(DAY,1,current_datetime) AS morgen_by_default
FROM "DATA".T_WAMAS_VPLK vk
LEFT JOIN vplp_ohne_thm vp
ON vp.client_id = vk.client_id
AND vp.wh_id = vk.wh_id
AND vp.lagerzone_nr = vk.laznr
AND vp.ksnr = vk.ksnr
AND CURRENT_DATE BETWEEN vk.dwh_valid_from AND vk.dwh_valid_to
AND vk.deleted_fg = FALSE
JOIN "DATA".T_WAMAS_LAZK lz
ON vk.client_id = lz.client_id
AND vk.wh_id = lz.wh_id
AND vk.laznr = lz.lazid_laznr
AND CURRENT_DATE BETWEEN lz.dwh_valid_from AND lz.dwh_valid_to
AND lz.deleted_fg = FALSE
AND lz.lazid_laztyp IN ('KOM')
AND CURRENT_DATE BETWEEN vk.dwh_valid_from AND vk.dwh_valid_to
AND vk.deleted_fg = FALSE;