CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TRANSP_AUFTRAG_LAGEREINHEIT_1
-- 02.03.2015 srom0404, Anforderung  612537
-- Die bisherige Ermittlung der WE-Standzeiten erfolgt nur über die Verknüpfung der LE.
-- Zum Teil werden LE's mehrfach genutzt. Dadurch kommt es zu falschen Daten.
-- In der Prüflogik zur Ermittlung der Standzeit soll zukünftig noch die Prüfung erfolgen, auf die Artikelnummer und den zeitlich nächsten TA
-- Umstellung auf Aggregat
-- 2021-07-08, AP0092666, dknop, adding entn_quittierzeit_einl, entn_quittierdatum_einl, standzeit_we_tor,standzeit_we_palette
-- 2021-08-24, nwag2310, INC3450977 - restoring this version which was overwritten by CDWH team
(
mandant_id
, wup_id
, nb_id
, art_id
, lagerort_id
, lagernummer_id_ta1
, nach_lagertyp_id_ta1
, nach_lagerplatz_id_ta1
, dat_erstellung
, entn_quittierdatum_einl
, entn_quittierzeit_einl
, quittierdatum_we
, quittierzeit_we
, quittierung_we
, lagernummer_id_ta2
, nach_lagertyp_id_ta2
, nach_lagerplatz_id_ta2
, quittierdatum_einlagerung
, quittierzeit_einlagerung
, quittierung_einlagerung
, lenr
, standzeit_we
, standzeit_we_tor
, standzeit_we_palette
, ta2_null_flg
, global_nach_lagertyp_id_ta2
)
AS
SELECT
   v01.mandant_id, 
   v01.wup_id, 
   v01.nb_id, 
   v01.art_id, 
   v01.lagerort_id, 
   v01.lagernummer_id_ta1, 
   v01.lagertyp_id_ta1 AS nach_lagertyp_id_ta1, 
   v01.lagerplatz_id_ta1 AS nach_lagerplatz_id_ta1, 
   v01.dat_erstellung, 
   CAST(v01.datzeit_entn_quittierung_einl AS DATE) AS entn_quittierdatum_einl, 
   CAST(v01.datzeit_entn_quittierung_einl AS TIME) AS entn_quittierzeit_einl, 
   CAST(v01.datzeit_quittierung_we AS DATE) AS quittierdatum_we, 
   CAST(v01.datzeit_quittierung_we AS TIME) AS quittierzeit_we, 
   v01.datzeit_quittierung_we AS quittierung_we, 
   v01.lagernummer_id_ta2, 
   v01.lagertyp_id_ta2 AS nach_lagertyp_id_ta2, 
   v01.lagerplatz_id_ta2 AS nach_lagerplatz_id_ta2, 
   CAST(v01.datzeit_quittierung_einl AS DATE) AS quittierdatum_einlagerung, 
   CAST(v01.datzeit_quittierung_einl AS TIME) AS quittierzeit_einlagerung, 
   v01.datzeit_quittierung_einl AS quittierung_einlagerung, 
   v01.lager_einheit_id AS lenr, 
   CAST(CASE WHEN v01.datzeit_quittierung_einl IS NOT NULL THEN (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_quittierung_we, v01.datzeit_quittierung_einl)):DAY * 86400 ) +
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_quittierung_we, v01.datzeit_quittierung_einl)):HOUR * 3600 ) +
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_quittierung_we, v01.datzeit_quittierung_einl)):MINUTE * 60 ) +
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_quittierung_we, v01.datzeit_quittierung_einl)):SECOND   )
        ELSE NULL
        END AS BIGINT) AS standzeit_we, 
           CAST(CASE WHEN v01.datzeit_quittierung_einl IS NOT NULL THEN (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_quittierung_we,v01.datzeit_entn_quittierung_einl)):DAY * 86400 ) +
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_quittierung_we, v01.datzeit_entn_quittierung_einl)):HOUR * 3600 ) +
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_quittierung_we, v01.datzeit_entn_quittierung_einl)):MINUTE * 60 ) +
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_quittierung_we, v01.datzeit_entn_quittierung_einl)):SECOND   )
        ELSE NULL
        END AS BIGINT) AS standzeit_we_tor, 
         CAST(CASE WHEN v01.datzeit_quittierung_einl IS NOT NULL THEN (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND,v01.datzeit_entn_quittierung_einl,datzeit_quittierung_einl)):DAY * 86400 ) +
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_entn_quittierung_einl,datzeit_quittierung_einl)):HOUR * 3600 ) +
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_entn_quittierung_einl,datzeit_quittierung_einl)):MINUTE * 60 ) +
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, v01.datzeit_entn_quittierung_einl,datzeit_quittierung_einl)):SECOND   )
        ELSE NULL
        END AS BIGINT) AS standzeit_we_palette, 
   CASE WHEN   v01.lagernummer_id_ta2 IS NULL THEN 1
        ELSE 0
        END AS ta2_null_flg, 
   CASE WHEN SUBSTR( v01.lagertyp_id_ta2, 1, 2) = 'R0' THEN 'Regal Erdgeschoss'
        WHEN SUBSTR( v01.lagertyp_id_ta2, 1, 2) = 'R1' THEN 'Regal Obergeschoss'
        WHEN SUBSTR( v01.lagertyp_id_ta2, 1, 1) = 'G' THEN 'Griffzone'
        ELSE 'Sonstige'
        END global_nach_lagertyp_id_ta2

   FROM dbp_view.v_standzeiten_we_1 v01;