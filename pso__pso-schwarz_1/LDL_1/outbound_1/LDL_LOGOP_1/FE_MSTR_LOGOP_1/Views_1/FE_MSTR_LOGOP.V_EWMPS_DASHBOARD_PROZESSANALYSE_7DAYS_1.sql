CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_ewmps_dashboard_prozessanalyse_7days_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), lagerzone_nr
OPTIONS(description='warehouse zone number'), kommissionierer OPTIONS(description='Picker'), ksnr
OPTIONS(description='Pick list number. PK/FK'), full_pallet_flag
OPTIONS(description='Indication of the amount of full pallet'), pbv_flag
OPTIONS(description='Indication of the Pick by Voice'), tour_mandant OPTIONS(description='TOUR_1 ID'), tour_1
OPTIONS(description='TOUR_1'), row_nr_tpa
OPTIONS(description='for the purpose of get the amount of the picker orders only once'), status_1
OPTIONS(description='status_1 of the commission'), matid_artid_artnr OPTIONS(description='Article Number'), position_nr
OPTIONS(description='position number'), tpmid
OPTIONS(description='ID of means for transport indicating if it is PbV or not'), komr
OPTIONS(description='picking order'), artbez OPTIONS(description='item_1 name'), pickfertzeit
OPTIONS(description='timestamp when a picking is finished'), lieferdatum OPTIONS(description='Delivery Date'),
bereitdatum OPTIONS(description='Stelldatum'), bereitzeit OPTIONS(description='Stellzeit'), picking_date
OPTIONS(description='date part of pickfertzeit'), hr_h OPTIONS(description='hour id'), hr_ss
OPTIONS(description='hour in time format'), picking_time OPTIONS(description='time part of pickfertzeit'),
be_vorlaufzeit OPTIONS(description='bereinigte Vorlaufzeit'), be_nachlaufzeit
OPTIONS(description='bereinigte Nachlaufzeit'), used_time_in_hour
OPTIONS(description='Used Hour for Picking pro position'), bestellte_kolli
OPTIONS(description='planned amount of picked collis'), fertig_kolli OPTIONS(description='the amount of picked collis'),
picked_cases OPTIONS(description='picked collis with status_1 is fertig and no transpoart pallet'), komm_eu_pal
OPTIONS(description='picked amount of EU Pallets'), komm_dd_pal OPTIONS(description='picked amount of DD Pallets'),
picks_eu OPTIONS(description='the amount of picks for EU Pallets'), picks_dd
OPTIONS(description='the amount of picks for DD Pallets'), anzahl_picks
OPTIONS(description='the amount of picks - for calculation of picks pro hour'), fertig_anzahl_picks
OPTIONS(description='the amount of picks with status_1 is finished and no transport pallet'), anzahl_paletten
OPTIONS(description='the amount of pallets'), anzahl_pausen OPTIONS(description='number of breaks'), pausenzeit_in_min
OPTIONS(description='breaktime in min'), row_nr
OPTIONS(description='support parameter to calculate the zone changing times'), wechsel
OPTIONS(description='for calculating the times of changing the zones'), dwh_updated
OPTIONS(description='Last update of table')) AS SELECT VP.client_id,
 VP.wh_id,
 VP.laznr AS lagerzone_nr,
 VP.pickuser AS kommissionierer,
 VP.ksnr,
  CASE
  WHEN VP.istmngs_hetefakt = 0 AND VP.istmngs_hele3fakt = 0 OR CAST(VP.matid_artid_artnr AS FLOAT64) < 10 OR VP.istmngs_mng
       < VP.istmngs_hetefakt AND VP.istmngs_mng < VP.istmngs_hele3fakt OR LOWER(VP.veeinheit) = 'pcs'
  THEN 0
  ELSE CASE
   WHEN CAST(VP.laznr AS FLOAT64) <> 20
   THEN CASE
    WHEN VP.istmngs_hetefakt > 1 AND MOD(CAST(VP.istmngs_mng AS BIGNUMERIC), CAST(VP.istmngs_hetefakt AS BIGNUMERIC)) =
      0
    THEN VP.istmngs_mng / VP.istmngs_hetefakt
    ELSE CASE
     WHEN VP.istmngs_hele3fakt > 1 AND MOD(CAST(VP.istmngs_mng AS BIGNUMERIC), CAST(VP.istmngs_hele3fakt AS BIGNUMERIC)
        ) = 0
     THEN VP.istmngs_mng / VP.istmngs_hele3fakt
     ELSE 0
     END
    END
   ELSE CASE
    WHEN VP.istmngs_hetefakt > 0 AND MOD(CAST(VP.istmngs_mng AS BIGNUMERIC), CAST(VP.istmngs_hetefakt AS BIGNUMERIC)) =
      0
    THEN VP.istmngs_mng / VP.istmngs_hetefakt
    ELSE CASE
     WHEN VP.istmngs_hele3fakt > 0 AND MOD(CAST(VP.istmngs_mng AS BIGNUMERIC), CAST(VP.istmngs_hele3fakt AS BIGNUMERIC)
        ) = 0
     THEN VP.istmngs_mng / VP.istmngs_hele3fakt
     ELSE 0
     END
    END
   END
  END AS full_pallet_flag,
 IF(LOWER(VP.tpmid) LIKE '%pbv%', 1, 0) AS pbv_flag,
 VK.tourid_mandant AS tour_mandant,
 VK.tourid_tour AS tour_1,
 ROW_NUMBER() OVER (PARTITION BY CAST(VP.client_id AS STRING), CAST(VP.wh_id AS STRING), VP.laznr, CAST(VP.ksnr AS STRING)
    , DATE(VP.pickfertzeit) ORDER BY DATE(VP.pickfertzeit) IS NULL DESC, DATE(VP.pickfertzeit) DESC) AS row_nr_tpa,
 VP.status_1,
 VP.matid_artid_artnr,
 VP.posnr AS position_nr,
 VP.tpmid,
 VP.komr,
 VP.artbez,
 VP.pickfertzeit,
 DATE(VK.liefterm) AS lieferdatum,
 DATE(VK.bereitterm) AS bereitdatum,
 TIME(CAST(TRIM(SUBSTR(SUBSTR(CAST(VK.bereitterm AS STRING), 1, 30), 12, 5)) AS TIME)) AS bereitzeit,
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
 VP.sollmngs_mng AS bestellte_kolli,
 VP.istmngs_mng AS fertig_kolli,
 IF(VP.status_1 = 'FERTIG' AND VP.posnr <> SAFE_CAST('9999999' as FLOAT64), VP.istmngs_mng, 0) AS picked_cases,
 VP.istmngs_hetefakt AS komm_eu_pal,
 VP.istmngs_hele3fakt AS komm_dd_pal,
 IF(VP.istmngs_mng = 0, 0, VP.istmngs_mng / NULLIF(VP.istmngs_hetefakt, 0)) AS picks_eu,
 IF(VP.istmngs_mng = 0, 0, VP.istmngs_mng / NULLIF(VP.istmngs_hele3fakt, 0)) AS picks_dd,
  CASE
  WHEN VP.istmngs_hetefakt > 0 AND VP.istmngs_mng >= VP.istmngs_hetefakt AND MOD(CAST(VP.istmngs_mng AS BIGNUMERIC), CAST(VP.istmngs_hetefakt AS BIGNUMERIC)
     ) = 0
  THEN IF(VP.istmngs_mng = 0, 0, VP.istmngs_mng / NULLIF(VP.istmngs_hetefakt, 0))
  ELSE CASE
   WHEN VP.istmngs_hele3fakt > 0 AND VP.istmngs_mng >= VP.istmngs_hele3fakt AND MOD(CAST(VP.istmngs_mng AS BIGNUMERIC), CAST(VP.istmngs_hele3fakt AS BIGNUMERIC)
      ) = 0
   THEN IF(VP.istmngs_mng = 0, 0, VP.istmngs_mng / NULLIF(VP.istmngs_hele3fakt, 0))
   ELSE VP.istmngs_mng
   END
  END AS anzahl_picks,
 IF(VP.status_1 = 'FERTIG' AND VP.posnr <> SAFE_CAST('9999999' as FLOAT64), CASE
   WHEN VP.istmngs_hetefakt > 0 AND VP.istmngs_mng >= VP.istmngs_hetefakt AND MOD(CAST(VP.istmngs_mng AS BIGNUMERIC), CAST(VP.istmngs_hetefakt AS BIGNUMERIC)
      ) = 0
   THEN IF(VP.istmngs_mng = 0, 0, VP.istmngs_mng / NULLIF(VP.istmngs_hetefakt, 0))
   ELSE CASE
    WHEN VP.istmngs_hele3fakt > 0 AND VP.istmngs_mng >= VP.istmngs_hele3fakt AND MOD(CAST(VP.istmngs_mng AS BIGNUMERIC)
       , CAST(VP.istmngs_hele3fakt AS BIGNUMERIC)) = 0
    THEN IF(VP.istmngs_mng = 0, 0, VP.istmngs_mng / NULLIF(VP.istmngs_hele3fakt, 0))
    ELSE VP.istmngs_mng
    END
   END, 0) AS fertig_anzahl_picks,
 IF(VP.posnr = SAFE_CAST('9999999' as FLOAT64), VP.istmngs_mng, 0) AS anzahl_paletten,
 VP.anzpause AS anzahl_pausen,
  VP.pausezeit / 60 AS pausenzeit_in_min,
 ROW_NUMBER() OVER (PARTITION BY CAST(VP.client_id AS STRING), CAST(VP.wh_id AS STRING), DATE(VP.pickfertzeit), VP.pickuser
    , VP.laznr ORDER BY VP.pickuser IS NULL, VP.pickuser) AS row_nr,
  CASE
  WHEN (COUNT(VP.laznr) OVER (PARTITION BY CAST(VP.client_id AS STRING), CAST(VP.wh_id AS STRING), VP.pickuser, DATE(VP
        .pickfertzeit) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 1
  THEN 1
  ELSE 0
  END AS wechsel,
 VP.dwh_updated
FROM ldl_logop_data.t_ewmps_vplp_1 AS VP
 LEFT JOIN ldl_logop_data.t_ewmps_vplk_1 AS VK_1 ON VP.client_id = VK.client_id AND VP.wh_id = VK.wh_id AND VP.laznr = VK.laznr
       AND VP.ksnr = VK.ksnr AND CURRENT_DATE BETWEEN VK.dwh_valid_from AND VK.dwh_valid_to AND NOT VK.deleted_fg
WHERE VP.laznr IS NOT NULL
 AND CURRENT_DATE BETWEEN VP.dwh_valid_from AND VP.dwh_valid_to
 AND DATE(VP.pickfertzeit) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY) AND (CURRENT_DATE)
 AND NOT VP.deleted_fg
 AND VP.pickuser IS NOT NULL;