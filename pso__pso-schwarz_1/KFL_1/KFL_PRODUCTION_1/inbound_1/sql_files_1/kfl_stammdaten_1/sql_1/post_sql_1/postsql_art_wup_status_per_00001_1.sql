CREATE volatile TABLE _marc_tracking AS (
SELECT DISTINCT
       b.art_id,
       b.mandant_id,
       b.wup_id,
       b.nb_id,
       a.dat_von,
       b.system_id,
       b.loesch_id,
       b.dat_bis,
       b.wg_verkett_id,
       b.fremd_lagerort_id,
       b.disponent_id,
       b.pps_plan_kalender_id,
       b.disposition_rhythmus_id,
       b.planlieferzeit,
       b.dispomerkmal,
       b.we_bearbeitungszeit,
       a.min_sicherh_bestand,
       b.anliefer_kalender,
       b.kdis,
       b.bezugsweg_id,
       b.terminierungsgruppe_1_id,
       b.terminierungsgruppe_2_id,
       b.terminierungsgruppe_3_id,
       a.sollbestand,
       b.dat_loesch_id,
       b.selbstabholung_fg
FROM ${TEMP_TABLE} a
JOIN DBP_DATA.art_wup_status_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.dat_von BETWEEN b.dat_von AND b.dat_bis AND
     a.dat_von <> b.dat_von
WHERE a.min_sicherh_bestand <> b.min_sicherh_bestand OR
      a.sollbestand <> b.sollbestand
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE volatile TABLE _upd AS (
SELECT mandant_id,
       wup_id,
       art_id,
       MIN(dat_von) AS dat_von,
       MAX(min_sicherh_bestand) AS min_sicherh_bestand,
       MAX(sollbestand) AS sollbestand
FROM _marc_tracking
GROUP BY 1,2,3
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO _marc_tracking
SELECT DISTINCT
       b.art_id,
       b.mandant_id,
       b.wup_id,
       b.nb_id,
       b.dat_von,
       b.system_id,
       b.loesch_id,
       CASE 
         WHEN a.dat_von = b.dat_von
         THEN b.dat_bis
         ELSE a.dat_von-1 
       END AS dat_bis,
       b.wg_verkett_id,
       b.fremd_lagerort_id,
       b.disponent_id,
       b.pps_plan_kalender_id,
       b.disposition_rhythmus_id,
       b.planlieferzeit,
       b.dispomerkmal,
       b.we_bearbeitungszeit,
       CASE 
         WHEN a.dat_von = b.dat_von
         THEN a.min_sicherh_bestand
         ELSE b.min_sicherh_bestand 
       END AS min_sicherh_bestand,
       b.anliefer_kalender,
       b.kdis,
       b.bezugsweg_id,
       b.terminierungsgruppe_1_id,
       b.terminierungsgruppe_2_id,
       b.terminierungsgruppe_3_id,
       CASE 
         WHEN a.dat_von = b.dat_von
         THEN a.sollbestand
         ELSE b.sollbestand 
       END AS sollbestand,
       b.dat_loesch_id,
       b.selbstabholung_fg
FROM ${TEMP_TABLE}/*DBP_ETL.art_wup_status_per_temp*/ a
JOIN DBP_DATA.art_wup_status_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.dat_von BETWEEN b.dat_von AND b.dat_bis
WHERE a.min_sicherh_bestand <> b.min_sicherh_bestand OR
      a.sollbestand <> b.sollbestand
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE volatile TABLE _kill AS (
SELECT mandant_id,
       wup_id,
       art_id,
       MIN(dat_von) AS dat_von,
       MAX(dat_bis) AS dat_bis
FROM _marc_tracking
GROUP BY 1,2,3
);

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM DBP_DATA.art_wup_status_per_1
WHERE (mandant_id,wup_id,art_id,dat_von) IN 
(SELECT a.mandant_id,
        a.wup_id,
        a.art_id,
        b.dat_von
  FROM  _kill a
  JOIN  DBP_DATA.art_wup_status_per_1 b
    ON  a.mandant_id = b.mandant_id AND
        a.wup_id = b.wup_id AND
        a.art_id = b.art_id AND
        b.dat_von BETWEEN a.dat_von AND a.dat_bis
 GROUP BY 1,2,3,4
)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.art_wup_status_per_1 
(        art_id
        ,mandant_id
        ,wup_id
        ,nb_id
        ,dat_von
        ,system_id
        ,loesch_id
        ,dat_bis
        ,wg_verkett_id
        ,fremd_lagerort_id
        ,disponent_id
        ,pps_plan_kalender_id
        ,disposition_rhythmus_id
        ,planlieferzeit
        ,dispomerkmal
        ,we_bearbeitungszeit
        ,min_sicherh_bestand
        ,anliefer_kalender
        ,kdis
        ,bezugsweg_id
        ,terminierungsgruppe_1_id
        ,terminierungsgruppe_2_id
        ,terminierungsgruppe_3_id
        ,sollbestand
        ,dat_loesch_id
        ,selbstabholung_fg
        ,td_insert
        ,td_update
)
SELECT art_id
      ,mandant_id
      ,wup_id
      ,nb_id
      ,dat_von
      ,system_id
      ,loesch_id
      ,dat_bis
      ,wg_verkett_id
      ,fremd_lagerort_id
      ,disponent_id
      ,pps_plan_kalender_id
      ,disposition_rhythmus_id
      ,planlieferzeit
      ,dispomerkmal
      ,we_bearbeitungszeit
      ,min_sicherh_bestand
      ,anliefer_kalender
      ,kdis
      ,bezugsweg_id
      ,terminierungsgruppe_1_id
      ,terminierungsgruppe_2_id
      ,terminierungsgruppe_3_id
      ,sollbestand
      ,dat_loesch_id
      ,selbstabholung_fg
      ,CURRENT_TIMESTAMP
      ,CURRENT_TIMESTAMP
FROM _marc_tracking
;

UPDATE DBP_DATA.art_wup_status_per_1 
SET min_sicherh_bestand = b.min_sicherh_bestand,
    sollbestand = b.sollbestand,
    td_update = CURRENT_TIMESTAMP

FROM (SELECT * FROM _upd) b
WHERE DBP_DATA.art_wup_status_per.mandant_id = b.mandant_id AND
      DBP_DATA.art_wup_status_per.wup_id = b.wup_id AND
      DBP_DATA.art_wup_status_per.art_id = b.art_id AND
      DBP_DATA.art_wup_status_per.dat_von >= b.dat_von
;

--SPEC0316398
UPDATE DBP_DATA.art_wup_status_per_1 a
SET a.dat_von = temp.dat_first_order
FROM
(
SELECT 
ekpo.mandant_id,
ekpo.art_id,
ekpo.wup_id,
marc.min_marc,
min(ekpo.dat_best_beleg) as dat_first_order
FROM dbp_data.besch_best_det_1 ekpo_1
     LEFT JOIN (select mandant_id, wup_id, art_id, min(dat_von) as min_marc from dbp_data.art_wup_status_per_1 group by mandant_id, wup_id, art_id) marc_1
	 ON ekpo.mandant_id = marc.mandant_id
        AND ekpo.art_id = marc.art_id
        AND ekpo.wup_id = marc.wup_id
        --AND ekpo.dat_best_beleg between marc.dat_von and marc.dat_bis
--WHERE ekpo.best_beleg_id=3102669317 and best_beleg_pos_id=30 --and ekpo.dat_best_beleg >= '2025-01-01'
--and ekpo.mandant_id=7         
GROUP BY 1,2,3,4
HAVING marc.min_marc > dat_first_order
) temp

WHERE a.mandant_id = temp.mandant_id 
AND a.art_id = temp.art_id
AND a.wup_id = temp.wup_id
AND a.dat_von = temp.min_marc
;
