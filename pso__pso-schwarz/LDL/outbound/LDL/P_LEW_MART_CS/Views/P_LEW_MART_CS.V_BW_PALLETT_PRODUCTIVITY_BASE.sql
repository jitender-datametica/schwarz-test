/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_PALLETT_PRODUCTIVITY_BASE
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_pallett_productivity_base (client_id, cy_month, org_unit_nr, org_type_id,
busyear_seq, paletten_warenausgang, palettenleistung_lager, nettostunden_gesamt, paletten_wareneingang, wb_nettokolli,
kilometer, nettostd_mitarbeiter_int, nettostd_mitarbeiter_ext, nettostd_gesamt_wb_retoure, kapazitaet,
paletten_warenausgang_up) AS SELECT client_id,
 cy_month,
 org_unit_nr,
 org_type_id,
 busyear_seq,
 SUM(paletten_warenausgang) AS paletten_warenausgang,
  CASE
  WHEN SUM(nettostunden_gesamt) <> 0
  THEN SUM(paletten_warenausgang) / SUM(nettostunden_gesamt)
  ELSE 0
  END AS palettenleistung_lager,
 SUM(nettostunden_gesamt) AS nettostunden_gesamt,
 SUM(paletten_wareneingang) AS paletten_wareneingang,
 SUM(wb_nettokolli) AS wb_nettokolli,
 SUM(kilometer) AS kilometer,
 SUM(nettostd_mitarbeiter_int) AS nettostd_mitarbeiter_int,
 SUM(nettostd_mitarbeiter_ext) AS nettostd_mitarbeiter_ext,
 SUM(nettostd_gesamt_wb_retoure) AS nettostd_gesamt_wb_retoure,
 SUM(kapazitaet) AS kapazitaet,
 SUM(paletten_warenausgang_up) AS paletten_warenausgang_up
FROM (SELECT cy_month,
   org_unit_nr,
   client_id,
   COALESCE(org_type_id, - 1) AS org_type_id,
   busyear_seq,
   SUM(paletten_warenausgang) AS paletten_warenausgang,
   SUM(nettostunden_gesamt) AS nettostunden_gesamt,
   SUM(paletten_wareneingang) AS paletten_wareneingang,
   SUM(wb_nettokolli) AS wb_nettokolli,
   SUM(kilometer) AS kilometer,
   SUM(nettostd_mitarbeiter_int) AS nettostd_mitarbeiter_int,
   SUM(nettostd_mitarbeiter_ext) AS nettostd_mitarbeiter_ext,
   SUM(nettostd_gesamt_wb_retoure) AS nettostd_gesamt_wb_retoure,
    CASE
    WHEN SUM(auslastungsgrad_lkw) > 0
    THEN SUM(paletten_warenausgang) / SUM(auslastungsgrad_lkw) * 100
    ELSE NULL
    END AS kapazitaet,
   SUM(paletten_warenausgang_up) AS paletten_warenausgang_up
  FROM (SELECT cy_month,
     dat_formdate,
     org_unit_nr,
     client_id,
     org_type_id,
     indicator_type_id,
     busyear_seq,
     SUM(paletten_warenausgang) AS paletten_warenausgang,
     SUM(nettostunden_gesamt) AS nettostunden_gesamt,
     SUM(paletten_wareneingang) AS paletten_wareneingang,
     SUM(wb_nettokolli) AS wb_nettokolli,
     SUM(auslastungsgrad_lkw) AS auslastungsgrad_lkw,
     SUM(kilometer) AS kilometer,
     SUM(nettostd_mitarbeiter_int) AS nettostd_mitarbeiter_int,
     SUM(nettostd_mitarbeiter_ext) AS nettostd_mitarbeiter_ext,
     SUM(nettostd_gesamt_wb_retoure) AS nettostd_gesamt_wb_retoure,
      CASE
      WHEN SUM(auslastungsgrad_lkw) > 0
      THEN SUM(paletten_warenausgang)
      ELSE 0
      END AS paletten_warenausgang_up
    FROM (SELECT VAL.dat_formdate,
       COALESCE(VAL.org_unit_nr, - 1) AS org_unit_nr,
       ORG.org_type_id,
       VAL.client_id,
       CAL.cy_month,
       CAL.busyear_seq,
       VAL.indicator_type_id,
        CASE
        WHEN VAL.indicator_id = 122
        THEN SUM(VAL.val_indicator)
        ELSE 0
        END AS paletten_warenausgang,
        CASE
        WHEN VAL.indicator_id = 123
        THEN SUM(VAL.val_indicator)
        ELSE 0
        END AS nettostunden_gesamt,
        CASE
        WHEN VAL.indicator_id = 315
        THEN SUM(VAL.val_indicator)
        ELSE 0
        END AS wb_nettokolli,
        CASE
        WHEN VAL.indicator_id = 316
        THEN SUM(VAL.val_indicator)
        ELSE 0
        END AS auslastungsgrad_lkw,
        CASE
        WHEN VAL.indicator_id = 317
        THEN SUM(VAL.val_indicator)
        ELSE 0
        END AS kilometer,
        CASE
        WHEN VAL.indicator_id = 318
        THEN SUM(VAL.val_indicator)
        ELSE 0
        END AS nettostd_mitarbeiter_int,
        CASE
        WHEN VAL.indicator_id = 319
        THEN SUM(VAL.val_indicator)
        ELSE 0
        END AS nettostd_mitarbeiter_ext,
        CASE
        WHEN VAL.indicator_id = 320
        THEN SUM(VAL.val_indicator)
        ELSE 0
        END AS nettostd_gesamt_wb_retoure,
        CASE
        WHEN VAL.indicator_id = 138
        THEN SUM(VAL.val_indicator)
        ELSE 0
        END AS paletten_wareneingang
      FROM ldl_p_lew_core_ac.v_wawi_indicator_day AS VAL
       INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_org_type AS ORG ON VAL.org_type_id = ORG.org_type_id
       INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON VAL.dat_formdate = CAL.cal_dt AND CAL.busyear_seq IN (-
          1, 0)
      WHERE VAL.indicator_id IN (121, 122, 123, 138, 315, 316, 317, 318, 319, 320)
       AND ORG.org_type_id IN (50, 20)
       AND VAL.indicator_type_id = 1
      GROUP BY CAL.cy_month,
       VAL.org_unit_nr,
       VAL.dat_formdate,
       VAL.indicator_id,
       CAL.busyear_seq,
       VAL.client_id,
       ORG.org_type_id,
       VAL.indicator_type_id) AS sub
    GROUP BY dat_formdate,
     org_unit_nr,
     org_type_id,
     client_id,
     cy_month,
     busyear_seq,
     indicator_type_id) AS sub
  GROUP BY cy_month,
   dat_formdate,
   org_unit_nr,
   client_id,
   org_type_id,
   indicator_type_id,
   busyear_seq) AS sub
GROUP BY cy_month,
 org_unit_nr,
 client_id,
 org_type_id,
 busyear_seq;