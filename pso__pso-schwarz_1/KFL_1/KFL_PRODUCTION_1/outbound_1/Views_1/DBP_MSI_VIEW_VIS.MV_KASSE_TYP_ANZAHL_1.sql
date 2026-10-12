/* Fakten für Anzahl Kassen eines Kassentyps pro Filiale und Tag_1 bzw. Zeitraum
2024-11-20 tekin: Initial */
-- , aenderungen
 -- ORDER BY mandant_id, wup_id, dat_von, dat_bis

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kasse_typ_anzahl_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), wup_id
OPTIONS(description='Der "WUP_1" beinhaltet Märkte und Lager. WUP_1 = WarenUmschlagsPlatz. Mutter WUP_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
anz_kasse_ges OPTIONS(description='Gesamtzahl von Kassen'), anz_kasse_00
OPTIONS(description='Anzahl an Kassen mit Kassentyp -1 oder 0 (default DWH, unbekannt)'), anz_kasse_01
OPTIONS(description='Anzahl an Kassen mit Kassentyp 1 (normal)'), anz_kasse_02
OPTIONS(description='Anzahl an Kassen mit Kassentyp 2 (Info)'), anz_kasse_03
OPTIONS(description='Anzahl an Kassen mit Kassentyp 3 (Leergut)'), anz_kasse_04
OPTIONS(description='Anzahl an Kassen mit Kassentyp 4 (Server)'), anz_kasse_05
OPTIONS(description='Anzahl an Kassen mit Kassentyp 5 (Imbiss)'), anz_kasse_06
OPTIONS(description='Anzahl an Kassen mit Kassentyp 6 (Mobile)'), anz_kasse_07
OPTIONS(description='Anzahl an Kassen mit Kassentyp 7 (Notfall)'), anz_kasse_08
OPTIONS(description='Anzahl an Kassen mit Kassentyp 8 (SCO)'), anz_kasse_09
OPTIONS(description='Anzahl an Kassen mit Kassentyp 9 (SCO cashless)'), anz_kasse_10
OPTIONS(description='Anzahl an Kassen mit Kassentyp 10 (Paystation)'), anz_kasse_11
OPTIONS(description='Anzahl an Kassen mit Kassentyp 11 (Paystation cashless)'), anz_kasse_konventionell
OPTIONS(description='Anzahl an konventionellen Kassen (Kassentyp 1, 3, 4, 5, 6, 7)'), anz_kasse_sco
OPTIONS(description='Anzahl an SCO Kassen (Kassentyp 8, 9, 10, 11)'), anz_kasse_sco_cash
OPTIONS(description='Anzahl an SCO Kassen mit Cash-Modul (Kassentyp 8, 10)'), dat_von
OPTIONS(description='Beginn des Gültigkeitzeitraums'), dat_bis OPTIONS(description='Ende des Gültigkeitzeitraums'),
valid_fg OPTIONS(description='Flag für aktuelle Gültigkeit'))
OPTIONS(DESCRIPTION = `Alle Kassentypen mit der zugehörigen Anzahl an Kassen pro Filiale und Zeitraum`) 
AS WITH FACTS AS
  (SELECT K.mandant_id,
   W.aktuell_wup_id AS wup_id,
   K.kasse_nr,
   K.dat_von,
   K.dat_bis,
   K.kasse_typ_id,
   T.dat -- , b.kasse_typ_bez
 -- , b.kasse_name_bez

  FROM kfl_production_dbp_view.v_kasse_typ_per_1 AS K
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS T ON T.dat BETWEEN K.dat_von AND K.dat_bis AND T.dat <= CURRENT_DATE
     -- INNER JOIN KFL_PRODUCTION.dbp_ods.kasse_typ_spr_zu_1 b -- Bezeichnungen fuer den Kassentyp (-1 default DWH, 0 unbekannt, 1 normal, 2 Info, 3 Leergut, 4 Server, 5 Imbiss, 6 Mobile, 7 Notfall, 8 SCO, 9 SCO cashless, 10 Paystation, 11 Paystation cashless)

     -- ON k.kasse_typ_id = b.kasse_typ_id

   INNER JOIN kfl_production_dbp_view.v_wup_1 AS W ON K.mandant_id = W.mandant_id AND K.wup_id = W.wup_id),
 NUMBER_OF_TILL_TYPES AS (SELECT mandant_id,
   wup_id,
   dat,
   COUNT(kasse_nr) AS anz_kasse_ges,
   COUNTIF(kasse_typ_id <= 0) AS anz_kasse_00,
   COUNTIF(kasse_typ_id = 1) AS anz_kasse_01,
   COUNTIF(kasse_typ_id = 2) AS anz_kasse_02,
   COUNTIF(kasse_typ_id = 3) AS anz_kasse_03,
   COUNTIF(kasse_typ_id = 4) AS anz_kasse_04,
   COUNTIF(kasse_typ_id = 5) AS anz_kasse_05,
   COUNTIF(kasse_typ_id = 6) AS anz_kasse_06,
   COUNTIF(kasse_typ_id = 7) AS anz_kasse_07,
   COUNTIF(kasse_typ_id = 8) AS anz_kasse_08,
   COUNTIF(kasse_typ_id = 9) AS anz_kasse_09,
   COUNTIF(kasse_typ_id = 10) AS anz_kasse_10,
   COUNTIF(kasse_typ_id = 11) AS anz_kasse_11
  FROM FACTS
  GROUP BY mandant_id,
   wup_id,
   dat), 
   TILL_TYPE_CHANGES AS (SELECT
  mandant_id,
  wup_id,
  dat,
  anz_kasse_ges,
  anz_kasse_00,
  anz_kasse_01,
  anz_kasse_02,
  anz_kasse_03,
  anz_kasse_04,
  anz_kasse_05,
  anz_kasse_06,
  anz_kasse_07,
  anz_kasse_08,
  anz_kasse_09,
  anz_kasse_10,
  anz_kasse_11,
  SUM(change_flag) OVER (
    PARTITION BY mandant_id, wup_id
    ORDER BY dat
  ) AS aenderungen
FROM (
  SELECT
    *,
    CASE
      WHEN concat_val != LAG(concat_val) OVER (
        PARTITION BY mandant_id, wup_id
        ORDER BY dat
      )
      THEN 1
      ELSE 0
    END AS change_flag
  FROM (
    SELECT
      mandant_id,
      wup_id,
      dat,
      anz_kasse_ges,
      anz_kasse_00,
      anz_kasse_01,
      anz_kasse_02,
      anz_kasse_03,
      anz_kasse_04,
      anz_kasse_05,
      anz_kasse_06,
      anz_kasse_07,
      anz_kasse_08,
      anz_kasse_09,
      anz_kasse_10,
      anz_kasse_11,
      CONCAT(
        CAST(anz_kasse_00 AS STRING),
        CAST(anz_kasse_01 AS STRING),
        CAST(anz_kasse_02 AS STRING),
        CAST(anz_kasse_03 AS STRING),
        CAST(anz_kasse_04 AS STRING),
        CAST(anz_kasse_05 AS STRING),
        CAST(anz_kasse_06 AS STRING),
        CAST(anz_kasse_07 AS STRING),
        CAST(anz_kasse_08 AS STRING),
        CAST(anz_kasse_09 AS STRING),
        CAST(anz_kasse_10 AS STRING),
        CAST(anz_kasse_11 AS STRING)
      ) AS concat_val
    FROM NUMBER_OF_TILL_TYPES) 
)
)
  (-- Filialumgliederung
 -- PK (mandant_id, wup_id, kasse_nr, dat_bis)

  /* count all tills per till type */
  /* identify changes of any till type to reduce the number of rows and cluster in change periods in the next step */
  -- Anzahl an Aenderungen in einer der Anzahlen von Kassen oder Kassentypen pro Tag_1

  /* aggregate rows by change and group them in validity_1 periods */
  -- Kassen konventionell (Kassentyp 1, 3, 4, 5, 6, 7)
 -- SCO Kassen (Kassentyp 8, 9, 10, 11)

  -- SCO Kassen mit Cash-Modul (Kassentyp 8, 10)
 -- shows the latest row for a store
 SELECT mandant_id,
   wup_id,
   anz_kasse_ges,
   anz_kasse_00,
   anz_kasse_01,
   anz_kasse_02,
   anz_kasse_03,
   anz_kasse_04,
   anz_kasse_05,
   anz_kasse_06,
   anz_kasse_07,
   anz_kasse_08,
   anz_kasse_09,
   anz_kasse_10,
   anz_kasse_11,
        anz_kasse_01 + anz_kasse_03 + anz_kasse_04 + anz_kasse_05 + anz_kasse_06 + anz_kasse_07 AS
   anz_kasse_konventionell,
      anz_kasse_08 + anz_kasse_09 + anz_kasse_10 + anz_kasse_11 AS anz_kasse_sco,
    anz_kasse_08 + anz_kasse_10 AS anz_kasse_sco_cash,
   MIN(dat) AS dat_von,
   MAX(dat) AS dat_bis,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING) ORDER BY MAX(dat) IS NULL DESC
         , MAX(dat) DESC)) = 1, 1, 0) AS valid_fg
  FROM TILL_TYPE_CHANGES
  GROUP BY mandant_id,
   wup_id,
   aenderungen,
   anz_kasse_ges,
   anz_kasse_00,
   anz_kasse_01,
   anz_kasse_02,
   anz_kasse_03,
   anz_kasse_04,
   anz_kasse_05,
   anz_kasse_06,
   anz_kasse_07,
   anz_kasse_08,
   anz_kasse_09,
   anz_kasse_10,
   anz_kasse_11);
