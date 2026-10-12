CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_EWMPS_DASHBOARD_PROZESSANALYSE_7DAYS_2(
   CLIENT_ID COMMENT 'Client id - calculated based on the country_2 code'
 , WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)'
 , LAGERZONE_NR COMMENT 'warehouse zone number'
 , KOMMISSIONIERER COMMENT 'Picker'
 , KSNR COMMENT 'Pick list number. PK/FK'
 , FULL_PALLET_FLAG COMMENT 'Indication of the amount of full pallet'
 , PBV_FLAG COMMENT 'Indication of the Pick by Voice'
 , TOUR_MANDANT COMMENT 'TOUR_2 ID'
 , TOUR_2 COMMENT 'TOUR_2'
 , ROW_NR_TPA COMMENT 'for the purpose of get the amount of the picker orders only once'
 , STATUS_2 COMMENT 'status_2 of the commission'
 , MATID_ARTID_ARTNR COMMENT 'Article Number'
 , POSITION_NR COMMENT 'position number'
 , TPMID COMMENT 'ID of means for transport indicating if it is PbV or not'
 , KOMR COMMENT 'picking order'
 , ARTBEZ COMMENT 'item_2 name'
 , PICKFERTZEIT COMMENT 'timestamp when a picking is finished'
 , LIEFERDATUM COMMENT 'Delivery Date'
 , BEREITDATUM COMMENT 'Stelldatum'
 , BEREITZEIT COMMENT 'Stellzeit'
 , PICKING_DATE COMMENT 'date part of pickfertzeit'
 , HR_H COMMENT 'hour id'
 , HR_SS COMMENT 'hour in time format'
 , PICKING_TIME COMMENT 'time part of pickfertzeit'
 , BE_VORLAUFZEIT COMMENT 'bereinigte Vorlaufzeit'
 , BE_NACHLAUFZEIT COMMENT 'bereinigte Nachlaufzeit'
 , USED_TIME_IN_HOUR COMMENT 'Used Hour for Picking pro position'
 , BESTELLTE_KOLLI COMMENT 'planned amount of picked collis'
 , FERTIG_KOLLI COMMENT 'the amount of picked collis'
 , PICKED_CASES COMMENT 'picked collis with status_2 is fertig and no transpoart pallet'
 , KOMM_EU_PAL COMMENT 'picked amount of EU Pallets'
 , KOMM_DD_PAL COMMENT 'picked amount of DD Pallets'
 , PICKS_EU COMMENT 'the amount of picks for EU Pallets'
 , PICKS_DD COMMENT 'the amount of picks for DD Pallets'
 , ANZAHL_PICKS COMMENT 'the amount of picks - for calculation of picks pro hour'
 , FERTIG_ANZAHL_PICKS COMMENT 'the amount of picks with status_2 is finished and no transport pallet'
 , ANZAHL_PALETTEN COMMENT 'the amount of pallets'
 , ANZAHL_PAUSEN COMMENT 'number of breaks'
 , PAUSENZEIT_IN_MIN COMMENT 'breaktime in min'
 , ROW_NR COMMENT 'support parameter to calculate the zone changing times'
 , WECHSEL COMMENT 'for calculating the times of changing the zones'
 , DWH_UPDATED COMMENT 'Last update of table'
) AS
SELECT
     vp.client_id
    ,vp.wh_id
    ,vp.laznr
    ,vp.pickuser
    ,vp.ksnr
    ,CASE 
	    WHEN (vp.istmngs_hetefakt =0 AND vp.istmngs_hele3fakt = 0) 
	    OR vp.matid_artid_artnr < 10  
	    OR (vp.istmngs_mng < vp.istmngs_hetefakt AND vp.istmngs_mng < vp.istmngs_hele3fakt)
	    OR LOWER(vp.veeinheit)='pcs' 
	    THEN 0
	 ELSE
	 	CASE 
	 		WHEN vp.laznr <> 20 
	 			THEN 
	 				CASE  
     					WHEN vp.istmngs_hetefakt >1 
     					AND MOD(vp.istmngs_mng, vp.istmngs_hetefakt) = 0 
     					THEN vp.istmngs_mng / vp.istmngs_hetefakt
     				ELSE 
     					CASE 
     						WHEN vp.istmngs_hele3fakt > 1 
     						AND MOD(vp.istmngs_mng, vp.istmngs_hele3fakt) = 0 
     						THEN vp.istmngs_mng / vp.istmngs_hele3fakt
     					ELSE 0
  		    			END
  		    		END
  		    ELSE 
  		    	CASE  
     				WHEN vp.istmngs_hetefakt >0 
     				AND MOD(vp.istmngs_mng, vp.istmngs_hetefakt) = 0
     				THEN vp.istmngs_mng / vp.istmngs_hetefakt
     			ELSE 
     				CASE 
     					WHEN vp.istmngs_hele3fakt > 0 
     					AND MOD(vp.istmngs_mng, vp.istmngs_hele3fakt) = 0
     					THEN vp.istmngs_mng / vp.istmngs_hele3fakt
     				ELSE 0
  		    		END
  		    	END
            END      
  	    END
    AS full_pallet_flag
    ,IFF(LOWER(vp.tpmid) LIKE '%pbv%',1,0) AS pbv_flag
    ,vk.tourid_mandant
    ,vk.tourid_tour
    ,ROW_NUMBER() OVER (PARTITION BY vp.client_id, vp.wh_id, vp.laznr, vp.ksnr, DATE(vp.pickfertzeit) ORDER BY DATE(vp.pickfertzeit) DESC) AS row_nr_TPA
    ,vp.status_2
    ,vp.matid_artid_artnr
    ,vp.posnr
    ,vp.tpmid
    ,vp.komr
    ,vp.artbez
    ,vp.pickfertzeit
    ,DATE(vk.liefterm)
    ,DATE(vk.bereitterm)
    ,TO_TIME(SUBSTRING(vk.bereitterm,12,5))
    ,DATE(vp.pickfertzeit) AS picking_date
    ,HOUR(vp.pickfertzeit) AS hr_h
    ,TO_TIME(CONCAT(SUBSTRING(vp.pickfertzeit,12,2),':00:00')) AS hr_ss
    ,TO_TIME(SUBSTRING(vp.pickfertzeit,12,5)) AS picking_time
    ,IFF(vp.vorlaufzeit >30000 OR vp.vorlaufzeit < 0,0,vp.vorlaufzeit) AS be_vorlaufzeit
    ,IFF(vp.nachlaufzeit > 30000 OR vp.nachlaufzeit < 0,0,vp.nachlaufzeit) AS be_nachlaufzeit
    ,IFF(DATE(vp.pickstartzeit) <> '1970-01-01' AND DATE(vp.pickfertzeit) <> '1970-01-01',(TIMEDIFF('sec',vp.pickstartzeit,vp.pickfertzeit)+be_vorlaufzeit + be_nachlaufzeit)/3600
    ,(be_vorlaufzeit + be_nachlaufzeit)/3600) AS used_time_in_hour
    ,vp.sollmngs_mng AS bestellte_kolli
    ,vp.istmngs_mng AS fertig_kolli
    ,IFF(vp.status_2 = 'FERTIG' AND vp.posnr <> '9999999',vp.istmngs_mng,0) AS picked_cases
    ,vp.istmngs_hetefakt AS komm_eu_pal
    ,vp.istmngs_hele3fakt AS komm_dd_pal
    ,IFF(vp.istmngs_mng = 0, 0, vp.istmngs_mng/NULLIF(vp.istmngs_hetefakt,0)) AS picks_eu
    ,IFF(vp.istmngs_mng = 0, 0, vp.istmngs_mng/NULLIF(vp.istmngs_hele3fakt,0)) AS picks_dd
    ,CASE 
    	WHEN vp.istmngs_hetefakt >0 AND vp.istmngs_mng >= vp.istmngs_hetefakt AND MOD(vp.istmngs_mng,vp.istmngs_hetefakt) = 0
   	THEN picks_eu
     ELSE 
     	CASE 
	    	WHEN vp.istmngs_hele3fakt > 0 AND vp.istmngs_mng >= vp.istmngs_hele3fakt AND MOD(vp.istmngs_mng,istmngs_hele3fakt)=0
THEN picks_dd
     	ELSE vp.istmngs_mng
     	END 
END AS anzahl_picks
	,IFF(vp.status_2 = 'FERTIG' AND vp.posnr <>'9999999',anzahl_picks,0) AS fertig_anzahl_picks 
	,IFF(vp.posnr='9999999',vp.istmngs_mng,0) AS anzahl_paletten
    ,vp.anzpause
    ,(vp.pausezeit)/60
    ,ROW_NUMBER() OVER (PARTITION BY vp.client_id, vp.wh_id, DATE(vp.pickfertzeit),vp.pickuser,vp.laznr  ORDER BY vp.pickuser ) AS row_nr
    ,CASE 
    	WHEN COUNT(DISTINCT vp.laznr) OVER (PARTITION BY vp.client_id, vp.wh_id,vp.pickuser, DATE(vp.pickfertzeit)) >1
    	THEN 1
    ELSE 0
    END Wechsel
    ,vp.dwh_updated
FROM "DATA".T_EWMPS_VPLP_2 VP
LEFT JOIN "DATA".T_EWMPS_VPLK_2 VK_2
ON vp.client_id = vk.client_id
AND vp.wh_id = vk.wh_id
AND vp.LAZNR = vk.laznr
AND vp.ksnr = vk.ksnr
AND vk.deleted_fg = FALSE
AND CURRENT_DATE BETWEEN vk.dwh_valid_from AND vk.dwh_valid_to
WHERE vp.LAZNR IS NOT NULL
AND vp.pickuser IS NOT NULL
AND vp.deleted_fg = FALSE
AND CURRENT_DATE BETWEEN vp.dwh_valid_from AND vp.dwh_valid_to
AND DATE(vp.pickfertzeit) BETWEEN CURRENT_DATE-7 AND CURRENT_DATE
;