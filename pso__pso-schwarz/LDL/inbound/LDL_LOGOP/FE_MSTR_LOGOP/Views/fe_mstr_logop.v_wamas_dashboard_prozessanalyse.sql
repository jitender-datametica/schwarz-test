/*
====================================================================================================
Division		    |	Lidl
Solution		    |	Operational Logistics (LOGOP)
DB schema			|	fe_mstr_logop.
DB table/view		|	v_wamas_dashboard_prozessanalyse
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_WAMAS_DASHBOARD_PROZESSANALYSE(
   CLIENT_ID COMMENT 'Client id - calculated based on the country code' 
 , WH_ID COMMENT 'Warehouse ID. Subset of Warehouse Number (lagernummer)' 
 , LAGERZONE_NR COMMENT 'warehouse zone number' 
 , KOMMISSIONIERER COMMENT 'Picker' 
 , KSNR COMMENT 'Pick list number. PK/FK' 
 , USERID COMMENT 'USER ID' 
 , FULL_PALLET_FLAG COMMENT 'Indication of the amount of full pallet' 
 , PBV_FLAG COMMENT 'Indication of the Pick by Voice' 
 , TOUR_MANDANT COMMENT 'TOUR ID' 
 , TOUR COMMENT 'TOUR' 
 , ROW_NR_TPA COMMENT 'for the purpose of get the amount of the picker orders only once' 
 , STATUS COMMENT 'status of the commission' 
 , MATID_ARTID_ARTNR COMMENT 'Article Number' 
 , POSITION_NR COMMENT 'position number' 
 , TPMID COMMENT 'ID of means for transport indicating if it is PbV or not' 
 , KOMR COMMENT 'picking order' 
 , ARTBEZ COMMENT 'item name' 
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
 , ANZAHL_PALLETEN COMMENT 'the amount of palletes calculated from fertig_kolli column' 
 , KOMM_EU_PAL COMMENT 'picked amount of EU Pallets' 
 , KOMM_DD_PAL COMMENT 'picked amount of DD Pallets' 
 , PICKS_EU COMMENT 'the amount of picks for EU Pallets' 
 , PICKS_DD COMMENT 'the amount of picks for DD Pallets' 
 , ANZAHL_PICKS COMMENT 'the amount of picks - for calculation of picks pro hour' 
 , ANZAHL_PAUSEN COMMENT 'number of breaks' 
 , PAUSENZEIT_IN_MIN COMMENT 'breaktime in min' 
 , ROW_NR COMMENT 'support parameter to calculate the zone changing times' 
 , WECHSEL COMMENT 'for calculating the times of changing the zones' 
 , DWH_UPDATED COMMENT 'Last update of table'
) COMMENT='View for WAMAS Dashboard 2.0 - process analysis'
 AS
SELECT
     vp.client_id
    ,vp.wh_id
    ,vp.lagerzone_nr
    ,IFF(vp.client_id = 27, NULL, vp.kommissionierer)
    ,vp.ksnr
	,CASE
		WHEN vp.client_id IN (13,16) AND vp.kommissionierer IS NOT NULL
		THEN vp.kommissionierer
		ELSE NULL
	 END AS USERID
    ,CASE 
	    WHEN (vp.istmngs_hetefakt =0 AND vp.istmngs_hele3fakt = 0) --ignore the EU AND DD factor 0
	    OR vp.matid_artid_artnr < 10  --ignore the transport pallets
	    OR (vp.fertig_kolli < vp.istmngs_hetefakt AND vp.fertig_kolli < vp.istmngs_hele3fakt)--ignore those picked amount smaller than the factor figure
	    OR LOWER(vp.VEEINHEIT)='pcs' -- ignore those with the unit 'pcs'
	    THEN 0
	 ELSE
	 	CASE 
	 		WHEN vp.lagerzone_nr <> 20 -- We ignore the factor of 1 except for lagerzone BLOCK
	 			THEN 
	 				CASE  
     					WHEN vp.istmngs_hetefakt >1 -- EU factor does not consider 1
     					AND MOD(vp.fertig_kolli, vp.istmngs_hetefakt) = 0 -- picked amount/factor must be an integer
     					THEN vp.fertig_kolli/vp.istmngs_hetefakt
     				ELSE 
     					CASE 
     						WHEN vp.istmngs_hele3fakt > 1 --DD factor does not consider 1
     						AND MOD(vp.fertig_kolli, vp.istmngs_hele3fakt) = 0 -- picked amount/factor must be an integer
     						THEN vp.fertig_kolli/vp.istmngs_hele3fakt
     					ELSE 0
  		    			END
  		    		END
  		    ELSE -- we start to check lagerzone BLOCK
  		    	CASE  
     				WHEN vp.istmngs_hetefakt >0 -- EU factor includes 1
     				AND MOD(vp.fertig_kolli, vp.istmngs_hetefakt) = 0
     				THEN vp.fertig_kolli/vp.istmngs_hetefakt
     			ELSE 
     				CASE 
     					WHEN vp.istmngs_hele3fakt > 0 -- DD factor includes 1 
     					AND MOD(vp.fertig_kolli, vp.istmngs_hele3fakt) = 0
     					THEN vp.fertig_kolli/vp.istmngs_hele3fakt
     				ELSE 0
  		    		END
  		    	END
            END      
  	    END
    AS full_pallet_flag
    ,IFF(LOWER(vp.tpmid) LIKE '%pbv%' OR vp.wh_id = 250 AND vp.tpmid LIKE '%Lut%' OR vp.wh_id = 250 AND vp.tpmid LIKE '%B2P%' ,1,0) AS pbv_flag
    ,vk.tourid_mandant
    ,vk.tourid_tour
    ,ROW_NUMBER() OVER (PARTITION BY vp.client_id, vp.wh_id, vp.lagerzone_nr, vp.ksnr, DATE(vp.pickfertzeit) ORDER BY DATE(vp.pickfertzeit) DESC) AS row_nr_TPA
    ,vp.status
    ,vp.matid_artid_artnr
    ,vp.position_nr
    ,vp.tpmid
    ,vp.komr
    ,vp.artbez
    ,vp.pickfertzeit
    ,vk.lieferdatum
    ,vk.bereitdatum
    ,vk.bereitzeit
    ,DATE(vp.pickfertzeit) AS picking_date
    ,HOUR(vp.pickfertzeit) AS hr_h
    ,TO_TIME(CONCAT(SUBSTRING(vp.pickfertzeit,12,2),':00:00')) AS hr_ss
    ,TO_TIME(SUBSTRING(vp.PICKFERTZEIT,12,5)) AS picking_time
    ,IFF(vp.vorlaufzeit >30000 OR vp.vorlaufzeit < 0,0,vp.vorlaufzeit) AS be_vorlaufzeit
    ,IFF(vp.nachlaufzeit > 30000 OR vp.nachlaufzeit < 0,0,vp.nachlaufzeit) AS be_nachlaufzeit
    ,IFF(DATE(vp.pickstartzeit) <> '1970-01-01' AND DATE(vp.pickfertzeit) <> '1970-01-01',(TIMEDIFF('sec',vp.pickstartzeit,vp.pickfertzeit)+be_vorlaufzeit + be_nachlaufzeit)/3600
    ,(be_vorlaufzeit + be_nachlaufzeit)/3600) AS used_time_in_hour
    ,vp.bestellte_kolli
    ,vp.fertig_kolli
	,CASE WHEN matid_artid_artnr = 1 THEN fertig_kolli*1
		 WHEN matid_artid_artnr = 2 THEN fertig_kolli*0.5
		 WHEN matid_artid_artnr = 3 THEN fertig_kolli*0.25
	     WHEN matid_artid_artnr = 4 THEN fertig_kolli*1
		 WHEN matid_artid_artnr = 5 THEN fertig_kolli*0.5 
		 ELSE 0 END AS anzahl_paletten
    ,vp.istmngs_hetefakt AS komm_eu_pal
    ,vp.istmngs_hele3fakt AS komm_dd_pal
    ,IFF(vp.bestellte_kolli = 0, 0, vp.istmngs_hetefakt/vp.bestellte_kolli) AS picks_eu
    ,IFF(vp.bestellte_kolli = 0, 0, vp.istmngs_hele3fakt/vp.bestellte_kolli) AS picks_dd
    ,CASE 
    	WHEN istmngs_hetefakt >0 AND bestellte_kolli >= istmngs_hetefakt AND MOD(istmngs_hetefakt,bestellte_kolli) = 0
    	THEN picks_eu
     ELSE 
     	CASE 
	     	WHEN istmngs_hele3fakt > 0 AND bestellte_kolli >= istmngs_hele3fakt AND MOD(istmngs_hele3fakt, bestellte_kolli)=0
     		THEN picks_dd
     	ELSE fertig_kolli
     	END 
     END AS anzahl_picks
    ,vp.anzahl_pausen
    ,vp.pausenzeit_in_min
    ,ROW_NUMBER() OVER (PARTITION BY vp.client_id, vp.wh_id, DATE(vp.PICKFERTZEIT),vp.KOMMISSIONIERER,vp.LAGERZONE_NR  ORDER BY vp.KOMMISSIONIERER ) AS row_nr
    ,CASE 
    	WHEN COUNT(DISTINCT vp.LAGERZONE_NR) OVER (PARTITION BY vp.client_id, vp.wh_id, DATE(vp.PICKFERTZEIT),vp.KOMMISSIONIERER) >1
    	THEN 1
    ELSE 0
    END Wechsel
    ,vp.dwh_updated
FROM "DATA".T_WAMAS_VPLP VP
LEFT JOIN "DATA".T_WAMAS_VPLK VK
ON vp.client_id = vk.client_id
AND vp.wh_id = vk.wh_id
AND vp.lagerzone_nr = vk.laznr
AND vp.ksnr = vk.ksnr
AND vk.deleted_fg = FALSE
AND CURRENT_DATE BETWEEN vk.dwh_valid_from AND vk.dwh_valid_to
WHERE vp.lagerzone_nr IS NOT NULL
AND vp.kommissionierer IS NOT NULL
AND vp.deleted_fg = FALSE
AND CURRENT_DATE BETWEEN vp.dwh_valid_from AND vp.dwh_valid_to
AND DATE(VP.PICKFERTZEIT) BETWEEN CURRENT_DATE-7 AND CURRENT_DATE
;