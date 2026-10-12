/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_PALLETT_PRODUCTIVITY_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_pallett_productivity_1 (client_id, iso_cd, cy_month, kpi_aspect, wh_id,
paletten_warenausgang, palettenleistung_lager, nettostunden_gesamt, paletten_wareneingang, palettenleistung_lager_aufgel
, wb_nettokolli, kilometer, nettostd_mitarbeiter_int, nettostd_mitarbeiter_ext, nettostd_gesamt_wb_retoure, kapazitaet,
paletten_warenausgang_up) AS
/* #----------------------------------------------------------------------------
   #Part 2 calculates the kpi for palettenleistung lager aufgel., which is calculated as paletten_warenausgang/nettostd_gesamt. It is compounding on a monthly basis, for each Lidl business year.
   #---------------------------------------------------------------------------- */
SELECT IND.client_id,
 CTY.src_country_lidl_cd AS iso_cd,
 IND.cy_month,
  CASE
  WHEN IND.org_type_id = 50
  THEN 'BGES'
  ELSE 'Land_1'
  END AS kpi_aspect,
  CASE
  WHEN IND.org_unit_nr = - 1
  THEN NULL
  ELSE IND.org_unit_nr
  END AS wh_id,
 IND.paletten_warenausgang,
 IND.palettenleistung_lager,
 IND.nettostunden_gesamt,
 IND.paletten_wareneingang,
 paletten_calc.palettenleistung_lager_aufgel,
 IND.wb_nettokolli,
 IND.kilometer,
 IND.nettostd_mitarbeiter_int,
 IND.nettostd_mitarbeiter_ext,
 IND.nettostd_gesamt_wb_retoure,
 IND.kapazitaet,
 IND.paletten_warenausgang_up
FROM ldl_p_lew_mart_cs.v_bw_pallett_productivity_base_1 AS IND
 INNER JOIN ldl_p_lew_core_ac.v_country_1 AS CTY ON IND.client_id = CTY.country_sid
 LEFT JOIN ldl_p_lew_core_ac.v_location_1 AS LOC ON IND.client_id = LOC.client_id AND IND.org_unit_nr = LOC.src_wh_id
 LEFT JOIN (SELECT cy_month,
   client_id,
   org_unit_nr,
   org_type_id,
    CASE
    WHEN (SUM(nettostunden_gesamt) OVER (PARTITION BY CAST(busyear_seq AS STRING), CAST(client_id AS STRING), CAST(org_unit_nr AS STRING)
         ORDER BY cy_month IS NULL, cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) <> 0
    THEN (SUM(paletten_warenausgang) OVER (PARTITION BY CAST(busyear_seq AS STRING), CAST(client_id AS STRING), CAST(org_unit_nr AS STRING)
         ORDER BY cy_month IS NULL, cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)) / (SUM(nettostunden_gesamt
       ) OVER (PARTITION BY CAST(busyear_seq AS STRING), CAST(client_id AS STRING), CAST(org_unit_nr AS STRING) ORDER BY
         cy_month IS NULL, cy_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW))
    ELSE 0
    END AS palettenleistung_lager_aufgel
  FROM ldl_p_lew_mart_cs.v_bw_pallett_productivity_base_1 AS IND) AS paletten_calc ON IND.cy_month = paletten_calc.cy_month
      AND IND.client_id = paletten_calc.client_id AND IND.org_type_id = paletten_calc.org_type_id AND IND.org_unit_nr =
   paletten_calc.org_unit_nr;