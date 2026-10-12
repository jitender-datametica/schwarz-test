/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_PALLETT_PRODUCTIVITY_BASE_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_PALLETT_PRODUCTIVITY_BASE_2
(
 client_id
,cy_month
,org_unit_nr
,org_type_id
,busyear_seq
,paletten_warenausgang
,palettenleistung_lager
,nettostunden_gesamt
,paletten_wareneingang
,wb_nettokolli
,kilometer
,nettostd_mitarbeiter_int
,nettostd_mitarbeiter_ext
,nettostd_gesamt_wb_retoure
,kapazitaet
,paletten_warenausgang_up
 )
AS
   SELECT client_id                                                               AS client_id,
   cy_month                                                               AS cy_month,
   org_unit_nr                                                            AS org_unit_nr,
   org_type_id                                                            AS org_type_id,
   busyear_seq                                                            AS busyear_seq,
   SUM(paletten_warenausgang)                                             AS paletten_warenausgang,
   CASE WHEN SUM(nettostunden_gesamt) <> 0
                  THEN SUM(paletten_warenausgang)/SUM(nettostunden_gesamt)
   ELSE 0
END                                                                    AS palettenleistung_lager,
   SUM(nettostunden_gesamt)                                               AS nettostunden_gesamt,
   SUM(paletten_wareneingang)                                             AS paletten_wareneingang,
   SUM(wb_nettokolli)                                                     AS wb_nettokolli,
   SUM(kilometer)                                                         AS kilometer,
   SUM(nettostd_mitarbeiter_int)                                          AS nettostd_mitarbeiter_int,
   SUM(nettostd_mitarbeiter_ext)                                          AS nettostd_mitarbeiter_ext,
   SUM(nettostd_gesamt_wb_retoure)                                        AS nettostd_gesamt_wb_retoure,
   SUM(kapazitaet)                                                        AS kapazitaet,
   SUM(paletten_warenausgang_up)                                          AS paletten_warenausgang_up
          FROM
         (

   SELECT client_id                                                               AS client_id,
   cy_month                                                               AS cy_month,
   dat_formdate                                                           AS dat_formdate,
   org_unit_nr                                                            AS org_unit_nr,
   COALESCE(org_type_id, -1)                                              AS org_type_id,
   busyear_seq                                                            AS busyear_seq,
   SUM(paletten_warenausgang)                                             AS paletten_warenausgang,
   SUM(nettostunden_gesamt)                                               AS nettostunden_gesamt,
   SUM(paletten_wareneingang)                                             AS paletten_wareneingang,
   SUM(wb_nettokolli)                                                     AS wb_nettokolli,
   SUM(auslastungsgrad_lkw)                                               AS auslastungsgrad_lkw,
   SUM(kilometer)                                                         AS kilometer,
   SUM(nettostd_mitarbeiter_int)                                          AS nettostd_mitarbeiter_int,
   SUM(nettostd_mitarbeiter_ext)                                          AS nettostd_mitarbeiter_ext,
   SUM(nettostd_gesamt_wb_retoure)                                        AS nettostd_gesamt_wb_retoure,
   CASE WHEN SUM(auslastungsgrad_lkw) > 0
                 THEN (SUM(paletten_warenausgang)/SUM(auslastungsgrad_lkw))*100
   ELSE NULL END                                                  AS kapazitaet,
   SUM(paletten_warenausgang_up)                                          AS paletten_warenausgang_up
          FROM
          (
   SELECT
          sub.cy_month                                                            AS cy_month,
   sub.dat_formdate                                                        AS dat_formdate,
   sub.busyear_seq                                                         AS busyear_seq,
   sub.org_unit_nr                                                         AS org_unit_nr,
   sub.org_type_id                                                         AS org_type_id,
   sub.indicator_type_id                                                   AS indicator_type_id,
   sub.client_id                                                           AS client_id,
   SUM(sub.paletten_warenausgang)                                          AS paletten_warenausgang,
   SUM(sub.nettostunden_gesamt)                                            AS nettostunden_gesamt,
   SUM(sub.paletten_wareneingang)                                          AS paletten_wareneingang,
   SUM(sub.wb_nettokolli)                                                  AS wb_nettokolli,
   SUM(sub.auslastungsgrad_lkw)                                            AS auslastungsgrad_lkw,
   SUM(sub.kilometer)                                                      AS kilometer,
   SUM(sub.nettostd_mitarbeiter_int)                                       AS nettostd_mitarbeiter_int,
   SUM(sub.nettostd_mitarbeiter_ext)                                       AS nettostd_mitarbeiter_ext,
   SUM(sub.nettostd_gesamt_wb_retoure)                                     AS nettostd_gesamt_wb_retoure,
   CASE WHEN SUM(auslastungsgrad_lkw) > 0
                THEN SUM(paletten_warenausgang)
                ELSE 0 END                                                        AS paletten_warenausgang_up
   FROM
   (
   SELECT
            cal.cy_month                                                          AS cy_month,
   val.dat_formdate                                                      AS dat_formdate,
   COALESCE(val.org_unit_nr, -1)                                         AS org_unit_nr,
   val.client_id                                                         AS client_id,
   org.org_type_id                                                       AS org_type_id,
   val.indicator_type_id                                                 AS indicator_type_id,
   cal.busyear_seq                                                       AS busyear_seq,
   CASE WHEN (val.indicator_id = 122)
                   THEN SUM(val.val_indicator)
                 ELSE 0
           END                                                                    AS paletten_warenausgang,
   CASE WHEN (val.indicator_id = 123)
                   THEN SUM(val.val_indicator)
                 ELSE 0
           END                                                                    AS nettostunden_gesamt,
   CASE WHEN (val.indicator_id = 315)
                  THEN SUM(val.val_indicator)
                 ELSE 0
           END                                                                    AS wb_nettokolli,
   CASE WHEN (val.indicator_id = 316)
                  THEN SUM(val.val_indicator)
                 ELSE 0
           END                                                                    AS auslastungsgrad_lkw,
   CASE WHEN (val.indicator_id = 317)
                  THEN SUM(val.val_indicator)
                 ELSE 0
           END                                                                    AS kilometer,
   CASE WHEN (val.indicator_id = 318)
                  THEN SUM(val.val_indicator)
                 ELSE 0
           END                                                                    AS nettostd_mitarbeiter_int,
   CASE WHEN (val.indicator_id = 319)
                  THEN SUM(val.val_indicator)
                 ELSE 0
           END                                                                    AS nettostd_mitarbeiter_ext,
   CASE WHEN (val.indicator_id = 320)
                  THEN SUM(val.val_indicator)
                 ELSE 0
           END                                                                    AS nettostd_gesamt_wb_retoure,
   CASE WHEN (val.indicator_id = 138)
                  THEN SUM(val.val_indicator)
                 ELSE 0
           END                                                                    AS paletten_wareneingang
      FROM p_lew_core_ac.v_wawi_indicator_day_2 AS val
   INNER JOIN p_lew_core_ac.v_wawi_ref_org_type_2 AS org
   ON val.org_type_id = org.org_type_id
   INNER JOIN p_lew_core_ac.v_cal_calendarday_2 AS cal
   ON val.dat_formdate = cal.cal_dt AND cal.busyear_seq IN (-1,0)
   WHERE val.indicator_id IN (121,122,123,138,315,316,317,318,319,320)
         AND org.org_type_id IN (50,20)
         AND val.indicator_type_id = 1
   GROUP BY
   cal.cy_month
            ,val.org_unit_nr
            ,val.dat_formdate
            ,val.indicator_id
            ,cal.busyear_seq
            ,val.client_id
            ,org.org_type_id
            ,val.indicator_type_id
) AS sub
GROUP BY
 sub.dat_formdate
,sub.org_unit_nr
,sub.org_type_id
,sub.client_id
,sub.cy_month
,sub.busyear_seq
,sub.indicator_type_id
) AS sub
 GROUP BY cy_month
          ,dat_formdate
          ,org_unit_nr
          ,client_id
          ,org_type_id
          ,indicator_type_id
          ,busyear_seq
) AS sub
 GROUP BY cy_month
          ,org_unit_nr
          ,client_id
          ,org_type_id
          ,busyear_seq
   ;