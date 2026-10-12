/*
====================================================================================================
Division		    |	Lidl
Solution		    |	Operational Logistics (LOGOP)
DB schema			|	fe_mstr_logop.
DB table/view		|	v_wamas_dashboard_prozessanalyse
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wamas_dashboard_prozessanalyse (client_id
OPTIONS(description='Client id - calculated based on the country code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), lagerzone_nr
OPTIONS(description='warehouse zone number'), kommissionierer OPTIONS(description='Picker'), ksnr
OPTIONS(description='Pick list number. PK/FK'), userid OPTIONS(description='USER ID'), full_pallet_flag
OPTIONS(description='Indication of the amount of full pallet'), pbv_flag
OPTIONS(description='Indication of the Pick by Voice'), tour_mandant OPTIONS(description='TOUR ID'), tour
OPTIONS(description='TOUR'), row_nr_tpa
OPTIONS(description='for the purpose of get the amount of the picker orders only once'), status
OPTIONS(description='status of the commission'), matid_artid_artnr OPTIONS(description='Article Number'), position_nr
OPTIONS(description='position number'), tpmid
OPTIONS(description='ID of means for transport indicating if it is PbV or not'), komr
OPTIONS(description='picking order'), artbez OPTIONS(description='item name'), pickfertzeit
OPTIONS(description='timestamp when a picking is finished'), lieferdatum OPTIONS(description='Delivery Date'),
bereitdatum OPTIONS(description='Stelldatum'), bereitzeit OPTIONS(description='Stellzeit'), picking_date
OPTIONS(description='date part of pickfertzeit'), hr_h OPTIONS(description='hour id'), hr_ss
OPTIONS(description='hour in time format'), picking_time OPTIONS(description='time part of pickfertzeit'),
be_vorlaufzeit OPTIONS(description='bereinigte Vorlaufzeit'), be_nachlaufzeit
OPTIONS(description='bereinigte Nachlaufzeit'), used_time_in_hour
OPTIONS(description='Used Hour for Picking pro position'), bestellte_kolli
OPTIONS(description='planned amount of picked collis'), fertig_kolli OPTIONS(description='the amount of picked collis'),
anzahl_palleten OPTIONS(description='the amount of palletes calculated from fertig_kolli column'), komm_eu_pal
OPTIONS(description='picked amount of EU Pallets'), komm_dd_pal OPTIONS(description='picked amount of DD Pallets'),
picks_eu OPTIONS(description='the amount of picks for EU Pallets'), picks_dd
OPTIONS(description='the amount of picks for DD Pallets'), anzahl_picks
OPTIONS(description='the amount of picks - for calculation of picks pro hour'), anzahl_pausen
OPTIONS(description='number of breaks'), pausenzeit_in_min OPTIONS(description='breaktime in min'), row_nr
OPTIONS(description='support parameter to calculate the zone changing times'), wechsel
OPTIONS(description='for calculating the times of changing the zones'), dwh_updated
OPTIONS(description='Last update of table')) OPTIONS(DESCRIPTION = `VIEW FOR WAMAS DASHBOARD 2.0 - PROCESS ANALYSIS`) AS
SELECT VP.client_id,
 VP.wh_id,
 VP.lagerzone_nr,
 IF(VP.client_id = 27, NULL, VP.kommissionierer) AS kommissionierer,
 VP.ksnr,
  CASE
  WHEN VP.client_id IN (13, 16) AND VP.kommissionierer IS NOT NULL
  THEN VP.kommissionierer
  ELSE NULL
  END AS userid,
  CASE
  WHEN VP.istmngs_hetefakt = 0 AND VP.istmngs_hele3fakt = 0 OR CAST(VP.matid_artid_artnr AS FLOAT64) < 10 OR VP.fertig_kolli
       < VP.istmngs_hetefakt AND VP.fertig_kolli < VP.istmngs_hele3fakt OR LOWER(VP.veeinheit) = 'pcs'
  THEN 0
  ELSE CASE
   WHEN CAST(VP.lagerzone_nr AS FLOAT64) <> 20
   THEN CASE
    WHEN VP.istmngs_hetefakt > 1 AND MOD(CAST(VP.fertig_kolli AS BIGNUMERIC), CAST(VP.istmngs_hetefakt AS BIGNUMERIC)) =
      0
    THEN VP.fertig_kolli / VP.istmngs_hetefakt
    ELSE CASE
     WHEN VP.istmngs_hele3fakt > 1 AND MOD(CAST(VP.fertig_kolli AS BIGNUMERIC), CAST(VP.istmngs_hele3fakt AS BIGNUMERIC)
        ) = 0
     THEN VP.fertig_kolli / VP.istmngs_hele3fakt
     ELSE 0
     END
    END
   ELSE CASE
    WHEN VP.istmngs_hetefakt > 0 AND MOD(CAST(VP.fertig_kolli AS BIGNUMERIC), CAST(VP.istmngs_hetefakt AS BIGNUMERIC)) =
      0
    THEN VP.fertig_kolli / VP.istmngs_hetefakt
    ELSE CASE
     WHEN VP.istmngs_hele3fakt > 0 AND MOD(CAST(VP.fertig_kolli AS BIGNUMERIC), CAST(VP.istmngs_hele3fakt AS BIGNUMERIC)
        ) = 0
     THEN VP.fertig_kolli / VP.istmngs_hele3fakt
     ELSE 0
     END
    END
   END
  END AS full_pallet_flag,
 IF(LOWER(VP.tpmid) LIKE '%pbv%' OR VP.wh_id = 250 AND VP.tpmid LIKE '%Lut%' OR VP.wh_id = 250 AND VP.tpmid LIKE '%B2P%'
     , 1, 0) AS pbv_flag,
 VK.tourid_mandant AS tour_mandant,
 VK.tourid_tour AS tour,
 ROW_NUMBER() OVER (PARTITION BY CAST(VP.client_id AS STRING), CAST(VP.wh_id AS STRING), VP.lagerzone_nr, CAST(VP.ksnr AS STRING)
    , DATE(VP.pickfertzeit) ORDER BY DATE(VP.pickfertzeit) IS NULL DESC, DATE(VP.pickfertzeit) DESC) AS row_nr_tpa,
 VP.status,
 VP.matid_artid_artnr,
 VP.position_nr,
 VP.tpmid,
 VP.komr,
 VP.artbez,
 VP.pickfertzeit,
 VK.lieferdatum,
 VK.bereitdatum,
 VK.bereitzeit,
 DATE(VP.pickfertzeit) AS picking_date,
 EXTRACT(HOUR FROM VP.pickfertzeit) AS hr_h,
 TIME(CAST(TRIM(CONCAT(SUBSTR(SUBSTR(CAST(VP.pickfertzeit AS STRING), 1, 30), 12, 2), ':00:00')) AS TIME)) AS hr_ss,
 TIME(CAST(TRIM(SUBSTR(SUBSTR(CAST(VP.pickfertzeit AS STRING), 1, 30), 12, 5)) AS TIME)) AS picking_time,
 IF(VP.vorlaufzeit > 30000 OR VP.vorlaufzeit < 0, 0, VP.vorlaufzeit) AS be_vorlaufzeit,
 IF(VP.nachlaufzeit > 30000 OR VP.nachlaufzeit < 0, 0, VP.nachlaufzeit) AS be_nachlaufzeit,
 IF(DATE(VP.pickstartzeit) <> SAFE_CAST('1970-01-01' as DATE) AND DATE(VP.pickfertzeit) <> SAFE_CAST('1970-01-01' as DATE
     ), (TIMESTAMP_DIFF(VP.pickfertzeit, VP.pickstartzeit, SECOND) + IF(VP.vorlaufzeit > 30000 OR VP.vorlaufzeit < 0, 0
       , VP.vorlaufzeit) + IF(VP.nachlaufzeit > 30000 OR VP.nachlaufzeit < 0, 0, VP.nachlaufzeit)) / 3600, (IF(VP.vorlaufzeit
         > 30000 OR VP.vorlaufzeit < 0, 0, VP.vorlaufzeit) + IF(VP.nachlaufzeit > 30000 OR VP.nachlaufzeit < 0, 0, VP.nachlaufzeit
      )) / 3600) AS used_time_in_hour,
 VP.bestellte_kolli,
 VP.fertig_kolli,
  CASE
  WHEN CAST(VP.matid_artid_artnr AS FLOAT64) = 1
  THEN CAST(VP.fertig_kolli AS FLOAT64)
  WHEN CAST(VP.matid_artid_artnr AS FLOAT64) = 2
  THEN VP.fertig_kolli * 0.5
  WHEN CAST(VP.matid_artid_artnr AS FLOAT64) = 3
  THEN VP.fertig_kolli * 0.25
  WHEN CAST(VP.matid_artid_artnr AS FLOAT64) = 4
  THEN CAST(VP.fertig_kolli AS FLOAT64)
  WHEN CAST(VP.matid_artid_artnr AS FLOAT64) = 5
  THEN VP.fertig_kolli * 0.5
  ELSE 0
  END AS anzahl_paletten,
 VP.istmngs_hetefakt AS komm_eu_pal,
 VP.istmngs_hele3fakt AS komm_dd_pal,
 IF(VP.bestellte_kolli = 0, 0, VP.istmngs_hetefakt / VP.bestellte_kolli) AS picks_eu,
 IF(VP.bestellte_kolli = 0, 0, VP.istmngs_hele3fakt / VP.bestellte_kolli) AS picks_dd,
  CASE
  WHEN VP.istmngs_hetefakt > 0 AND VP.bestellte_kolli >= VP.istmngs_hetefakt AND MOD(CAST(VP.istmngs_hetefakt AS BIGNUMERIC)
     , CAST(VP.bestellte_kolli AS BIGNUMERIC)) = 0
  THEN IF(VP.bestellte_kolli = 0, 0, VP.istmngs_hetefakt / VP.bestellte_kolli)
  ELSE CASE
   WHEN VP.istmngs_hele3fakt > 0 AND VP.bestellte_kolli >= VP.istmngs_hele3fakt AND MOD(CAST(VP.istmngs_hele3fakt AS BIGNUMERIC)
      , CAST(VP.bestellte_kolli AS BIGNUMERIC)) = 0
   THEN IF(VP.bestellte_kolli = 0, 0, VP.istmngs_hele3fakt / VP.bestellte_kolli)
   ELSE VP.fertig_kolli
   END
  END AS anzahl_picks,
 VP.anzahl_pausen,
 VP.pausenzeit_in_min,
 ROW_NUMBER() OVER (PARTITION BY CAST(VP.client_id AS STRING), CAST(VP.wh_id AS STRING), DATE(VP.pickfertzeit), VP.kommissionierer
    , VP.lagerzone_nr ORDER BY VP.kommissionierer IS NULL, VP.kommissionierer) AS row_nr,
  CASE
  WHEN (COUNT(VP.lagerzone_nr) OVER (PARTITION BY CAST(VP.client_id AS STRING), CAST(VP.wh_id AS STRING), DATE(VP.pickfertzeit
        ), VP.kommissionierer RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 1
  THEN 1
  ELSE 0
  END AS wechsel,
 VP.dwh_updated
FROM ldl_logop_data.t_wamas_vplp AS VP
 LEFT JOIN ldl_logop_data.t_wamas_vplk AS VK ON VP.client_id = VK.client_id AND VP.wh_id = VK.wh_id AND VP.lagerzone_nr
      = VK.laznr AND VP.ksnr = VK.ksnr AND CURRENT_DATE BETWEEN VK.dwh_valid_from AND VK.dwh_valid_to AND NOT VK.deleted_fg
  
WHERE VP.lagerzone_nr IS NOT NULL
 AND CURRENT_DATE BETWEEN VP.dwh_valid_from AND VP.dwh_valid_to
 AND DATE(VP.pickfertzeit) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY) AND (CURRENT_DATE)
 AND NOT VP.deleted_fg
 AND VP.kommissionierer IS NOT NULL;