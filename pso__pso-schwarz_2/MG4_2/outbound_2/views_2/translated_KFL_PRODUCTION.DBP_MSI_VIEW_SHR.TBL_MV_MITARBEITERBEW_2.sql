-- Änderung der Berechnung erfolgte am 26.11.2019
 -- Berechnung Betriebszugehörigkeit des Mitarbeiters

-- Berechnung Eintrittsdatum 03
 -- ,MIN(v100.dat_von) AS dat_von

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.tbl_mv_mitarbeiterbew_2 AS WITH eintrittsdatum_03 AS (SELECT v036.mandant_id
   -- ,v036.datumsart_id
,
   v036.mitarbeiter_id,
   v036.kjmo,
   v036.dat_von,
   MAX(v998.dat_von) AS dat_von_wenn_austritt,
   MAX(v999.dat_von) AS dat_austritt_datumsart_id_05,
    CASE
    WHEN CAST(EXTRACT(MONTH FROM v036.dat_von) AS BIGNUMERIC) = CAST(EXTRACT(MONTH FROM MAX(v999.dat_von)) AS BIGNUMERIC)
       AND CAST(EXTRACT(YEAR FROM v036.dat_von) AS BIGNUMERIC) = CAST(EXTRACT(YEAR FROM MAX(v999.dat_von)) AS BIGNUMERIC)
      
    THEN MAX(v998.dat_von)
    ELSE v036.dat_von
    END AS bzg_dat_von
  FROM kfl_production_dbp_view.v_ma_datumsart_zu_per_2 AS v036
   LEFT JOIN kfl_production_dbp_view.v_ma_datumsart_zu_per_2 AS v999 ON v036.mandant_id = v999.mandant_id AND v036.mitarbeiter_id
         = v999.mitarbeiter_id AND v999.datumsart_id = '05' AND v036.dat_von > v999.dat_von AND v999.kjmo >= CAST(REPLACE(SUBSTR(SUBSTR(CAST(v999.dat_von AS STRING)
         , 1, 20), 1, 7), '-', '') AS FLOAT64)
   LEFT JOIN kfl_production_dbp_view.v_ma_datumsart_zu_per_2 AS v998 ON v036.mandant_id = v998.mandant_id AND v036.mitarbeiter_id
        = v998.mitarbeiter_id AND v998.datumsart_id = '02' AND v036.dat_von > v998.dat_von
  WHERE v036.datumsart_id IN ('02')
   -- wird benoetigt damit datenmuell entfernt wird sowAS wie eIN Dat_von mit dem Jahr 2200

   AND v036.dat_von <= CURRENT_DATE
  GROUP BY v036.mandant_id,
   v036.mitarbeiter_id,
   v036.kjmo,
   v036.dat_von) (-- Hier muss auf Monat_2 und Jahr geprueft werden

  -- dies wird benoetigt, um Daten rauszufiltern bei denen KJMO kleiner ist als dAS Dat_Von
 -- ab hier dAS MAIN Select

  -- Ausahmen für alle Länder
 -- Ausnahme_2 für HR
 -- Dienstleistung
 -- Logistik
 -- CZ-9800

  -- alte Logik für alle übrigen Kostenstellenebene4_ids
 -- ENDE shr_ma_funktion_id_funktion

  -- Bedingungen aus dem ApplySimple aus der Metrik IN View übernommen

  -- Und jetzt dAS gleiche nochmal, nur anders. Warum weiss vermutlich keiner... SPEC0064121

  -- Kann zu anderen Ergebnissen führen als dAS Case-Statement hier drüber.

  -- die folgenden 2 Felder werden nur benötigt für die Generierung der funktionsänderungs_id

  -- Berechnung Alter des Mitarbeiters zum 31.12. des jeweiligen Jahres

  -- 17.03.2023, Alter wird nicht mehr errechnet, kommt direkt aus der Quelle, Umsezung mit SPEC SPEC0143976

  -- v094.dat_von_wiedereintritt im ersten Fall, da hier max gezogen wird, im Falle von mehreren Austritten

  -- , ROUND(CASE WHEN (v094.dat_von IS  NOT NULL AND wiedereintritt_monatlich = 0) THEN (v094.dat_von_wiedereintritt - v07.dat_geburtstag) / 365.25

  -- ELSE (v100.stichtag - v07.dat_geburtstag) / 365.25 END,2)AS errechnetes_alter

  /* ,CASE WHEN v094.dat_von IS  NULL THEN  (MONTHS_BETWEEN(v100.stichtag, v07.dat_geburtstag) + 1 ) /12
ELSE  MONTHS_BETWEEN(v094.dat_von, v07.dat_geburtstag) / 12 END  AS errechnetes_alter_monatsende */
  -- Wenn keIN Eintrittsdatum gepflegt ist, wird -1 gesetzt
 -- Änderung der Berechnung der BZG START

  -- BZG IN Monaten
 -- Achtung: Änderung für Snowflake
 -- BZG IN Tagen
 -- Änderung der Berechnung der BZG END

  /* ,COALESCE(CASE WHEN v094.dat_von IS  NULL THEN  CAST(MONTHS_BETWEEN (v100.stichtag , COALESCE(v033.dat_von, v035.dat_von, v036.dat_von) + 1) AS NUMERIC(4, 1))
ELSE  CAST(MONTHS_BETWEEN( v094.dat_von , COALESCE(v033.dat_von, v035.dat_von, v036.dat_von)) AS NUMERIC(4, 1))
END, -1)    AS  betriebszugehoerigkeit_bereinigt
--BZG IN Tagen
,COALESCE(CASE WHEN v094.dat_von IS  NULL THEN  v100.stichtag - COALESCE(v033.dat_von, v035.dat_von, v036.dat_von) + 1
ELSE  v094.dat_von - COALESCE(v033.dat_von, v035.dat_von, v036.dat_von) END, -1)   AS  betriebszugehoerigkeit_bereinigt_in_tagen */
  -- BZG Cluster nach Monaten
 -- DAYS_BETWEEN((DATE) , (  DATE -1))) AS INTEGER
 -- kann wohl gelöscht werden

  -- SPEC0117578 BGZ Schwarzlogik
 -- fuer die Sortierung
 -- löschbar nach Fertigstellung FE Moldau

  -- comnent FDS, initions: dbp_view.v_ma_kostenstelle_lohnart_zu_per_2 wird ausgelagert

  -- ,CASE WHEN v096.mitarbeiter_id IS  NOT NULL THEN v096.anzahl_lohnart ELSE 0 END AS aushilfe_cz_sk_stunden

  -- Einführung Flag Arbeitsunfall + Berücksichtigung LZA noch einbauen + Austritt -> wiedereintritt??

  -- ,MIN(v091.dat_von) AS dat_von

  -- ,MAX(v091.betriebszugehoerigkeit_jahresende) AS betriebszugehoerigkeit_jahresende

  -- ,CASE WHEN (v100.kjmo MOD 100 ) = 12 THEN betriebszugehoerigkeit ELSE NULL END AS betriebszugehoerigkeit_jahresende

  -- Berechnung des Datums aus kjmo
 -- ,v08.min_dat AS err_dat

  -- Berechnung der Mitarbeiter, wo eine_2 Kündigung vorliegt
 -- Berechnung Anzahl Monate bIS  Vertragsende / Kündigung

  -- ,CAST((vertragsende - err_dat MONTH(4)) AS INTEGER) AS anz_mon_vertragsende

  -- Definition Flag, ob Datum Vertragsende <6 Monate
 -- CROSS JOIN KFL_PRODUCTION.dbp_view.v_monat_2 v08

  -- ON v100.kjmo = v08.kjmo
 -- Einführung MAX für Wiedereintrittslogik
 -- with clause

  -- Einführung MAX für Wiedereintrittslogik
 -- Die Stunden_2 der AzubIS  CZ und HR
 -- AzubIS  CZ
 -- AzubIS  HR

  -- WHERE v099.mandant_id = 6 AND lohnart_id IN ('MVST')
 -- WHERE v099.mandant_id = 6 AND lohnart_id IN ('MVST')

  -- , MAX(arbeitsunfall_folgeabw_fg) AS arbeitsunfall_folgeabw_fg

  -- Subselect, um Arbeitsunfälle zu identifizieren, die folgender Logik genügen: Differenz zwischen 2 Arbeitsunfällen, wenn <=3 -Tage> 1 Arbeitsunfall , > 3Tage mehrere AUs

  -- kjmo aus dat_von extrahieren zum joinen gg mitarbeiterbew_2 -> damit ist SchiefstAND dat_von und kjmo aus ma_abwesenh_zu_per_2 behoben

  -- Anpassung für Snowflake

  -- Bestimmung des dat_bIS  aus der Vorperiode für die gleiche Mandant_2, Mitarbeiter, Abwesenheit Kombination

  -- Bestimmung Differenz aktPeriode zu Vorperiode: 1000, wenn keine Vorperiode vorhanden
 SELECT v01.mandant_id,
   v01.mitarbeiter_id,
   v01.kjmo -- , ADD_MONTHS(CAST(v01.kjmo*100-19000000+1 AS DATE),-1)/100 + 190000  AS kjmo_vm
,
   ROUND(CAST(FORMAT_DATE('%Y%m', IF(PARSE_DATE('%Y%m', SAFE_CAST(v01.kjmo as STRING)) = LAST_DAY(PARSE_DATE('%Y%m', SAFE_CAST(v01.kjmo as STRING))), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(v01.kjmo as STRING)), INTERVAL - 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(v01.kjmo as STRING))
        ,INTERVAL - 1 MONTH))) AS BIGNUMERIC), 0) AS kjmo_vm,
   v101.mitarbeiter_gruppe_id,
   v102.mitarbeiter_kreis_id,
   v103.kostenstelle_id,
   v01.abwesenheit_tage,
   v01.soll_stunden_monat,
   v01.abr_stunden_monat,
   v01.langzeit_abwesend_fg,
   v0111.langzeit_abwesend_fg AS langzeit_abwesend_fg_vm,
   v01.neu_mitarbeiter_fg,
   v01.krank_tage,
   v01.teilzeit_fg,
   v01.hr_objekt_id,
   v01.ma_status_id,
   v0111.ma_status_id AS ma_status_id_vm,
   v01.geschlecht_id,
   v01.tarifgebiet_id,
   TRIM(v01.shr_ma_funktion_id) AS shr_ma_funktion_id,
   v2.kostenstelle_ebene4_id -- Snowflake Anpssung: blanks aus dem LIKE entfernt
 -- shr_ma_funktion_id_2
,
    CASE
    WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
    THEN CASE
     WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
     THEN '13'
     WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
     THEN '22' -- Ausnahme_2 für CZ

     WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND
         v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
     THEN '13' -- Standardfall

     ELSE CASE
      WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
      THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
      ELSE '99'
      END
     END
    ELSE CASE
     WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
     THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
     ELSE '99'
     END
    END AS shr_ma_funktion_id_2,
    CASE
    WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
    THEN CASE
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (11)
     THEN 'MA'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (12)
     THEN 'MA'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (13)
     THEN 'MA'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (14)
     THEN 'Erstkraft'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (15)
     THEN 'PSB'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (21)
     THEN 'WBL_2'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (22)
     THEN 'HL_2'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (23)
     THEN 'HL_2'
     ELSE 'nicht zugeordnet'
     END
    WHEN v2.kostenstelle_ebene4_id LIKE '%-DLGES%'
    THEN CASE
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (11)
     THEN 'MA1'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (12)
     THEN 'MA2'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (13)
     THEN 'MA3'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (14)
     THEN 'MA4'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (15)
     THEN 'MA5'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (16)
     THEN 'MA6'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (21)
     THEN 'FE6'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (22)
     THEN 'FE5'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (23)
     THEN 'FE4'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (31)
     THEN 'FE4 ppa.'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (32)
     THEN 'FE3 GF_2'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (33)
     THEN 'FE2 GL'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (34)
     THEN 'FE1 GLV'
     ELSE 'nicht zugeordnet'
     END
    WHEN v2.kostenstelle_ebene4_id LIKE '%-LOG%' OR v2.kostenstelle_ebene4_id LIKE '%CZ-9800%'
    THEN CASE
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (11)
     THEN 'MA1'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (12)
     THEN 'MA2'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (13)
     THEN 'MA3'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (14)
     THEN 'MA4'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (15)
     THEN 'MA5'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (16)
     THEN 'MA6'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (21)
     THEN 'FE6'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (22)
     THEN 'FE5'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (23)
     THEN 'FE4'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (31)
     THEN 'FE4 ppa.'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (32)
     THEN 'FE3 GF_2'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (33)
     THEN 'FE2 GL'
     ELSE 'nicht zugeordnet'
     END
    ELSE CASE
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (11)
     THEN 'MA'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (12)
     THEN 'MA'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (13)
     THEN 'MA'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (14)
     THEN 'Erstkraft'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (15)
     THEN 'PSB'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (16)
     THEN 'TL'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (21)
     THEN 'WBL_2'
     WHEN CAST(CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
         THEN '13'
         WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
         THEN '22' -- Ausnahme_2 für CZ

         WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
         THEN '13' -- Standardfall

         ELSE CASE
          WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
          THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
          ELSE '99'
          END
         END
        ELSE CASE
         WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
         THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
         ELSE '99'
         END
        END AS INTEGER) IN (22)
     THEN 'HL_2'
     ELSE 'nicht zugeordnet'
     END
    END AS shr_ma_funktion_id_funktion,
    CASE
    WHEN CASE
         WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
         THEN CASE
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (11)
          THEN 'MA'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (12)
          THEN 'MA'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (13)
          THEN 'MA'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (14)
          THEN 'Erstkraft'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (15)
          THEN 'PSB'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (21)
          THEN 'WBL_2'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (22)
          THEN 'HL_2'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (23)
          THEN 'HL_2'
          ELSE 'nicht zugeordnet'
          END
         WHEN v2.kostenstelle_ebene4_id LIKE '%-DLGES%'
         THEN CASE
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (11)
          THEN 'MA1'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (12)
          THEN 'MA2'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (13)
          THEN 'MA3'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (14)
          THEN 'MA4'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (15)
          THEN 'MA5'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (16)
          THEN 'MA6'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (21)
          THEN 'FE6'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (22)
          THEN 'FE5'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (23)
          THEN 'FE4'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (31)
          THEN 'FE4 ppa.'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (32)
          THEN 'FE3 GF_2'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (33)
          THEN 'FE2 GL'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (34)
          THEN 'FE1 GLV'
          ELSE 'nicht zugeordnet'
          END
         WHEN v2.kostenstelle_ebene4_id LIKE '%-LOG%' OR v2.kostenstelle_ebene4_id LIKE '%CZ-9800%'
         THEN CASE
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (11)
          THEN 'MA1'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (12)
          THEN 'MA2'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (13)
          THEN 'MA3'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (14)
          THEN 'MA4'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (15)
          THEN 'MA5'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (16)
          THEN 'MA6'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (21)
          THEN 'FE6'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (22)
          THEN 'FE5'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (23)
          THEN 'FE4'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (31)
          THEN 'FE4 ppa.'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (32)
          THEN 'FE3 GF_2'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (33)
          THEN 'FE2 GL'
          ELSE 'nicht zugeordnet'
          END
         ELSE CASE
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (11)
          THEN 'MA'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (12)
          THEN 'MA'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (13)
          THEN 'MA'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (14)
          THEN 'Erstkraft'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (15)
          THEN 'PSB'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (16)
          THEN 'TL'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (21)
          THEN 'WBL_2'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (22)
          THEN 'HL_2'
          ELSE 'nicht zugeordnet'
          END
         END LIKE 'HL_2' OR CASE
         WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
         THEN CASE
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (11)
          THEN 'MA'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (12)
          THEN 'MA'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (13)
          THEN 'MA'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (14)
          THEN 'Erstkraft'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (15)
          THEN 'PSB'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (21)
          THEN 'WBL_2'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (22)
          THEN 'HL_2'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (23)
          THEN 'HL_2'
          ELSE 'nicht zugeordnet'
          END
         WHEN v2.kostenstelle_ebene4_id LIKE '%-DLGES%'
         THEN CASE
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (11)
          THEN 'MA1'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (12)
          THEN 'MA2'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (13)
          THEN 'MA3'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (14)
          THEN 'MA4'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (15)
          THEN 'MA5'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (16)
          THEN 'MA6'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (21)
          THEN 'FE6'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (22)
          THEN 'FE5'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (23)
          THEN 'FE4'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (31)
          THEN 'FE4 ppa.'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (32)
          THEN 'FE3 GF_2'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (33)
          THEN 'FE2 GL'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (34)
          THEN 'FE1 GLV'
          ELSE 'nicht zugeordnet'
          END
         WHEN v2.kostenstelle_ebene4_id LIKE '%-LOG%' OR v2.kostenstelle_ebene4_id LIKE '%CZ-9800%'
         THEN CASE
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (11)
          THEN 'MA1'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (12)
          THEN 'MA2'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (13)
          THEN 'MA3'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (14)
          THEN 'MA4'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (15)
          THEN 'MA5'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (16)
          THEN 'MA6'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (21)
          THEN 'FE6'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (22)
          THEN 'FE5'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (23)
          THEN 'FE4'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (31)
          THEN 'FE4 ppa.'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (32)
          THEN 'FE3 GF_2'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (33)
          THEN 'FE2 GL'
          ELSE 'nicht zugeordnet'
          END
         ELSE CASE
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (11)
          THEN 'MA'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (12)
          THEN 'MA'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (13)
          THEN 'MA'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (14)
          THEN 'Erstkraft'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (15)
          THEN 'PSB'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (16)
          THEN 'TL'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (21)
          THEN 'WBL_2'
          WHEN CAST(CASE
             WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
             THEN CASE
              WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
              THEN '13'
              WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
              THEN '22' -- Ausnahme_2 für CZ

              WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
              THEN '13' -- Standardfall

              ELSE CASE
               WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
               THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
               ELSE '99'
               END
              END
             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END AS INTEGER) IN (22)
          THEN 'HL_2'
          ELSE 'nicht zugeordnet'
          END
         END LIKE 'WBL_2' OR CASE
        WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
        THEN CASE
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (11)
         THEN 'MA'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (12)
         THEN 'MA'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (13)
         THEN 'MA'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (14)
         THEN 'Erstkraft'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (15)
         THEN 'PSB'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (21)
         THEN 'WBL_2'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (22)
         THEN 'HL_2'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (23)
         THEN 'HL_2'
         ELSE 'nicht zugeordnet'
         END
        WHEN v2.kostenstelle_ebene4_id LIKE '%-DLGES%'
        THEN CASE
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (11)
         THEN 'MA1'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (12)
         THEN 'MA2'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (13)
         THEN 'MA3'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (14)
         THEN 'MA4'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (15)
         THEN 'MA5'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (16)
         THEN 'MA6'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (21)
         THEN 'FE6'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (22)
         THEN 'FE5'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (23)
         THEN 'FE4'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (31)
         THEN 'FE4 ppa.'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (32)
         THEN 'FE3 GF_2'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (33)
         THEN 'FE2 GL'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (34)
         THEN 'FE1 GLV'
         ELSE 'nicht zugeordnet'
         END
        WHEN v2.kostenstelle_ebene4_id LIKE '%-LOG%' OR v2.kostenstelle_ebene4_id LIKE '%CZ-9800%'
        THEN CASE
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (11)
         THEN 'MA1'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (12)
         THEN 'MA2'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (13)
         THEN 'MA3'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (14)
         THEN 'MA4'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (15)
         THEN 'MA5'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (16)
         THEN 'MA6'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (21)
         THEN 'FE6'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (22)
         THEN 'FE5'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (23)
         THEN 'FE4'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (31)
         THEN 'FE4 ppa.'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (32)
         THEN 'FE3 GF_2'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (33)
         THEN 'FE2 GL'
         ELSE 'nicht zugeordnet'
         END
        ELSE CASE
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (11)
         THEN 'MA'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (12)
         THEN 'MA'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (13)
         THEN 'MA'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (14)
         THEN 'Erstkraft'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (15)
         THEN 'PSB'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (16)
         THEN 'TL'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (21)
         THEN 'WBL_2'
         WHEN CAST(CASE
            WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
            THEN CASE
             WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
             THEN '13'
             WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
             THEN '22' -- Ausnahme_2 für CZ

             WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
             THEN '13' -- Standardfall

             ELSE CASE
              WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
              THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
              ELSE '99'
              END
             END
            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END AS INTEGER) IN (22)
         THEN 'HL_2'
         ELSE 'nicht zugeordnet'
         END
        END LIKE 'PSB' OR CASE
       WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
       THEN CASE
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (11)
        THEN 'MA'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (12)
        THEN 'MA'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (13)
        THEN 'MA'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (14)
        THEN 'Erstkraft'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (15)
        THEN 'PSB'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (21)
        THEN 'WBL_2'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (22)
        THEN 'HL_2'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (23)
        THEN 'HL_2'
        ELSE 'nicht zugeordnet'
        END
       WHEN v2.kostenstelle_ebene4_id LIKE '%-DLGES%'
       THEN CASE
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (11)
        THEN 'MA1'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (12)
        THEN 'MA2'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (13)
        THEN 'MA3'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (14)
        THEN 'MA4'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (15)
        THEN 'MA5'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (16)
        THEN 'MA6'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (21)
        THEN 'FE6'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (22)
        THEN 'FE5'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (23)
        THEN 'FE4'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (31)
        THEN 'FE4 ppa.'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (32)
        THEN 'FE3 GF_2'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (33)
        THEN 'FE2 GL'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (34)
        THEN 'FE1 GLV'
        ELSE 'nicht zugeordnet'
        END
       WHEN v2.kostenstelle_ebene4_id LIKE '%-LOG%' OR v2.kostenstelle_ebene4_id LIKE '%CZ-9800%'
       THEN CASE
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (11)
        THEN 'MA1'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (12)
        THEN 'MA2'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (13)
        THEN 'MA3'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (14)
        THEN 'MA4'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (15)
        THEN 'MA5'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (16)
        THEN 'MA6'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (21)
        THEN 'FE6'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (22)
        THEN 'FE5'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (23)
        THEN 'FE4'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (31)
        THEN 'FE4 ppa.'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (32)
        THEN 'FE3 GF_2'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (33)
        THEN 'FE2 GL'
        ELSE 'nicht zugeordnet'
        END
       ELSE CASE
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (11)
        THEN 'MA'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (12)
        THEN 'MA'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (13)
        THEN 'MA'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (14)
        THEN 'Erstkraft'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (15)
        THEN 'PSB'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (16)
        THEN 'TL'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (21)
        THEN 'WBL_2'
        WHEN CAST(CASE
           WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
           THEN CASE
            WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
            THEN '13'
            WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
            THEN '22' -- Ausnahme_2 für CZ

            WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
            THEN '13' -- Standardfall

            ELSE CASE
             WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
             THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
             ELSE '99'
             END
            END
           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END AS INTEGER) IN (22)
        THEN 'HL_2'
        ELSE 'nicht zugeordnet'
        END
       END LIKE 'Erstkraft'
    THEN 'Führungsebene'
    WHEN CASE
      WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
      THEN CASE
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (11)
       THEN 'MA'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (12)
       THEN 'MA'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (13)
       THEN 'MA'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (14)
       THEN 'Erstkraft'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (15)
       THEN 'PSB'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (21)
       THEN 'WBL_2'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (22)
       THEN 'HL_2'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (23)
       THEN 'HL_2'
       ELSE 'nicht zugeordnet'
       END
      WHEN v2.kostenstelle_ebene4_id LIKE '%-DLGES%'
      THEN CASE
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (11)
       THEN 'MA1'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (12)
       THEN 'MA2'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (13)
       THEN 'MA3'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (14)
       THEN 'MA4'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (15)
       THEN 'MA5'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (16)
       THEN 'MA6'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (21)
       THEN 'FE6'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (22)
       THEN 'FE5'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (23)
       THEN 'FE4'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (31)
       THEN 'FE4 ppa.'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (32)
       THEN 'FE3 GF_2'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (33)
       THEN 'FE2 GL'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (34)
       THEN 'FE1 GLV'
       ELSE 'nicht zugeordnet'
       END
      WHEN v2.kostenstelle_ebene4_id LIKE '%-LOG%' OR v2.kostenstelle_ebene4_id LIKE '%CZ-9800%'
      THEN CASE
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (11)
       THEN 'MA1'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (12)
       THEN 'MA2'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (13)
       THEN 'MA3'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (14)
       THEN 'MA4'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (15)
       THEN 'MA5'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (16)
       THEN 'MA6'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (21)
       THEN 'FE6'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (22)
       THEN 'FE5'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (23)
       THEN 'FE4'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (31)
       THEN 'FE4 ppa.'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (32)
       THEN 'FE3 GF_2'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (33)
       THEN 'FE2 GL'
       ELSE 'nicht zugeordnet'
       END
      ELSE CASE
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (11)
       THEN 'MA'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (12)
       THEN 'MA'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (13)
       THEN 'MA'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (14)
       THEN 'Erstkraft'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (15)
       THEN 'PSB'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (16)
       THEN 'TL'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (21)
       THEN 'WBL_2'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (22)
       THEN 'HL_2'
       ELSE 'nicht zugeordnet'
       END
      END LIKE 'MA%'
    THEN 'Mitarbeiterebene'
    WHEN CASE
      WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
      THEN CASE
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (11)
       THEN 'MA'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (12)
       THEN 'MA'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (13)
       THEN 'MA'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (14)
       THEN 'Erstkraft'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (15)
       THEN 'PSB'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (21)
       THEN 'WBL_2'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (22)
       THEN 'HL_2'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (23)
       THEN 'HL_2'
       ELSE 'nicht zugeordnet'
       END
      WHEN v2.kostenstelle_ebene4_id LIKE '%-DLGES%'
      THEN CASE
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (11)
       THEN 'MA1'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (12)
       THEN 'MA2'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (13)
       THEN 'MA3'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (14)
       THEN 'MA4'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (15)
       THEN 'MA5'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (16)
       THEN 'MA6'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (21)
       THEN 'FE6'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (22)
       THEN 'FE5'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (23)
       THEN 'FE4'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (31)
       THEN 'FE4 ppa.'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (32)
       THEN 'FE3 GF_2'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (33)
       THEN 'FE2 GL'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (34)
       THEN 'FE1 GLV'
       ELSE 'nicht zugeordnet'
       END
      WHEN v2.kostenstelle_ebene4_id LIKE '%-LOG%' OR v2.kostenstelle_ebene4_id LIKE '%CZ-9800%'
      THEN CASE
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (11)
       THEN 'MA1'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (12)
       THEN 'MA2'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (13)
       THEN 'MA3'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (14)
       THEN 'MA4'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (15)
       THEN 'MA5'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (16)
       THEN 'MA6'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (21)
       THEN 'FE6'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (22)
       THEN 'FE5'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (23)
       THEN 'FE4'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (31)
       THEN 'FE4 ppa.'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (32)
       THEN 'FE3 GF_2'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (33)
       THEN 'FE2 GL'
       ELSE 'nicht zugeordnet'
       END
      ELSE CASE
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (11)
       THEN 'MA'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (12)
       THEN 'MA'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (13)
       THEN 'MA'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (14)
       THEN 'Erstkraft'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (15)
       THEN 'PSB'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (16)
       THEN 'TL'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (21)
       THEN 'WBL_2'
       WHEN CAST(CASE
          WHEN v2.kostenstelle_ebene4_id LIKE '%-VT%'
          THEN CASE
           WHEN v01.shr_ma_funktion_id LIKE '14-009-1%' OR v01.shr_ma_funktion_id LIKE '14-017-1%'
           THEN '13'
           WHEN v01.shr_ma_funktion_id LIKE '23-003-3%'
           THEN '22' -- Ausnahme_2 für CZ

           WHEN v01.shr_ma_funktion_id LIKE '14-013-1%' AND v01.mandant_id = 2 OR v01.shr_ma_funktion_id LIKE '14-001-2%' AND v01.mandant_id = 6 OR v01.shr_ma_funktion_id LIKE '14-016-1%' AND v01.mandant_id = 6
           THEN '13' -- Standardfall

           ELSE CASE
            WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
            THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
            ELSE '99'
            END
           END
          ELSE CASE
           WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
           THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
           ELSE '99'
           END
          END AS INTEGER) IN (22)
       THEN 'HL_2'
       ELSE 'nicht zugeordnet'
       END
      END LIKE 'FE%'
    THEN 'Fach-/Führungsebene'
    ELSE 'nicht zugeordnet'
    END AS shr_ma_hierarchiestufe_funktion,
    CASE
    WHEN TRIM(v01.shr_ma_funktion_id) LIKE '%-3' AND (TRIM(v01.shr_ma_funktion_id) LIKE '2%' OR TRIM(v01.shr_ma_funktion_id
         ) LIKE '3%')
    THEN 'Führungsebene'
    WHEN TRIM(v01.shr_ma_funktion_id) NOT LIKE '%-3' AND (TRIM(v01.shr_ma_funktion_id) LIKE '2%' OR TRIM(v01.shr_ma_funktion_id
         ) LIKE '3%')
    THEN 'Fachebene'
    WHEN TRIM(v01.shr_ma_funktion_id) LIKE '1%'
    THEN 'MA-Ebene'
    ELSE 'nicht zugeordnet'
    END AS shr_ma_fach_fuer_ebene,
    CASE
    WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
    THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
    ELSE '99'
    END AS shr_ma_funktionsaenderung1,
    CASE
    WHEN SUBSTR(mbew.shr_ma_funktion_id, 3, 1) = '-'
    THEN SUBSTR(mbew.shr_ma_funktion_id, 1, 2)
    ELSE '99'
    END AS shr_ma_funktionsaenderung2,
    CASE
    WHEN CASE
      WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
      THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
      ELSE '99'
      END > CASE
      WHEN SUBSTR(mbew.shr_ma_funktion_id, 3, 1) = '-'
      THEN SUBSTR(mbew.shr_ma_funktion_id, 1, 2)
      ELSE '99'
      END
    THEN 3
    WHEN CASE
      WHEN SUBSTR(v01.shr_ma_funktion_id, 3, 1) = '-'
      THEN SUBSTR(v01.shr_ma_funktion_id, 1, 2)
      ELSE '99'
      END < CASE
      WHEN SUBSTR(mbew.shr_ma_funktion_id, 3, 1) = '-'
      THEN SUBSTR(mbew.shr_ma_funktion_id, 1, 2)
      ELSE '99'
      END
    THEN 1
    ELSE 2
    END AS shr_ma_funktionaenderung_id,
   v01.tarifart_id,
   v01.unternehmens_bereich_id,
   v01.gehalts_region_id,
   v01.haus_kategorie_id,
   v01.haupt_mitarbeiter_id,
   v01.soll_kalender_tage,
   v01.resturlaub_vj,
   v01.resturlaub_akt_kj,
   v01.anspruch_urlaub_akt_kj,
   v01.genommen_urlaub,
   v01.langzeit_krank_fg,
   v01.mutterschutz_fg,
   v01.beschaeftigungs_verbot_fg,
   v01.aushilfe_fg,
   v01.elternzeit_fg,
   v01.grundwehrdienst_fg,
   v01.atz_kz,
   v01.freigestellt_fg,
   v01.impatriates_fg,
   v01.externe_fg,
   v01.azubi_fg,
    CASE
    WHEN v03.kalendertage - v01.soll_kalender_tage <> 0 AND CAST(v01.ma_status_id AS INTEGER) IN (0) AND v01.azubi_fg =
      1
    THEN 1
    ELSE 0
    END AS untermonatlich_azubi_fg,
   v01.ma_eintritt_kz,
   v01.ma_austritt_kz,
   v01.fluktuation_kz,
   v03.def_vollzeit_stunden,
   v03.kalendertage,
   v01.ki_fg,
   v01.untermonatlich_fg,
   v01.inventur_aushilfe_fg,
   v01.tip_austraeger_fg,
   v01.tip_kontrolleur_fg,
   v01.tip_gebietsbetreuer_fg,
   v01.diplomand_praktikant_fg,
   v01.praktikant_o_entgeld_fg,
   v01.expatriates_fg,
   v01.hinterbliebene_fg,
   v01.versorgungsbezieher_fg,
    CASE
    WHEN v01.neu_mitarbeiter_fg = 1 AND v01.azubi_fg = 0
    THEN 1
    ELSE 0
    END AS neumitarbeiter_ohne_azubi_fg,
    CASE
    WHEN v01.mandant_id = 1 AND v020.buchungskreis_id NOT IN (1, 220, 234, 80)
    THEN 'DE'
    WHEN v01.mandant_id = 1 AND v020.buchungskreis_id IN (1, 220, 234, 80)
    THEN 'KI'
    WHEN v01.mandant_id = 2 AND v020.mandant_id = 2
    THEN 'CZ'
    WHEN v01.mandant_id = 3 AND v020.mandant_id = 3
    THEN 'PL'
    WHEN v01.mandant_id = 4 AND v020.mandant_id = 4
    THEN 'MD'
    WHEN v01.mandant_id = 5 AND v020.mandant_id = 5
    THEN 'SK'
    WHEN v01.mandant_id = 6 AND v020.mandant_id = 6
    THEN 'HR'
    WHEN v01.mandant_id = 7 AND v020.mandant_id = 7
    THEN 'RO'
    WHEN v01.mandant_id = 8 AND v020.mandant_id = 8
    THEN 'BG'
    ELSE '0'
    END AS org_gruppierung_,
   CAST(v01.abwesenheit_arbeitstage_bez + v01.abwesenheit_arbeitstage_unbez AS NUMERIC) AS abwesenheit_arbeitstage,
   v01.soll_arbeitstage,
   v01.arbeitszeit_anteil -- , v099.arbeitszeit_anteil_hr
,
    CASE
    WHEN v099.mandant_id IS NOT NULL
    THEN v099.arbeitszeit_anteil_hr
    ELSE 0
    END AS arbeitszeit_anteil_hr,
   v01.abwesenheit_arbeitstage_bez,
   v01.abwesenheit_arbeitstage_unbez,
   v01.arb_stunden_tag,
    CASE
    WHEN DATE_SUB(v094.dat_von_wiedereintritt, INTERVAL 1 DAY) < v035.dat_von_wiedereintritt AND CAST(EXTRACT(MONTH FROM v094.dat_von_wiedereintritt) AS BIGNUMERIC)
        = CAST(EXTRACT(MONTH FROM v035.dat_von_wiedereintritt) AS BIGNUMERIC) AND v094.mitarbeiter_id IS NOT NULL AND
     v035.mitarbeiter_id IS NOT NULL
    THEN 1
    ELSE 0
    END AS wiedereintritt_monatlich,
   v07.dat_geburtstag AS geburtsdatum,
   EXTRACT(YEAR FROM v07.dat_geburtstag) AS geburtsjahr,
   v01.mitarbeiter_alter,
    CASE
    WHEN v01.mitarbeiter_alter < 30
    THEN 1
    ELSE NULL
    END AS unter30,
    CASE
    WHEN v01.mitarbeiter_alter >= 30 AND v01.mitarbeiter_alter < 50
    THEN 1
    ELSE NULL
    END AS zwischen30u50,
    CASE
    WHEN v01.mitarbeiter_alter >= 50
    THEN 1
    ELSE NULL
    END AS ueber50,
   v100.stichtag,
   v09.betriebszugehoerigkeit -- kann wohl gelöscht werden

   /* , v10.betriebszugehoerigkeit_monatsende -- kann wohl gelöscht werden */,
    CASE
    WHEN v09.betriebszugehoerigkeit IN (0)
    THEN 'beinhaltet < 1 Jahr'
    WHEN v09.betriebszugehoerigkeit IN (1, 2)
    THEN 'beinhaltet 1 - 2 Jahre'
    WHEN v09.betriebszugehoerigkeit IN (3, 4)
    THEN 'beinhaltet 3 - 4 Jahre'
    WHEN v09.betriebszugehoerigkeit IN (5, 6, 7, 8, 9)
    THEN 'beinhaltet 5 - 9 Jahre'
    WHEN v09.betriebszugehoerigkeit IN (10)
    THEN 'beinhaltet 10 Jahre'
    ELSE 'beinhaltet > 10 Jahre'
    END AS betriebszugehoerigkeit_anzeige,
   COALESCE(CASE
     WHEN v094.dat_von IS NULL
     THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v100.stichtag AS STRING), 1
          , 20)), CAST(TIMESTAMP_SECONDS(CAST(DATE_ADD(v036.bzg_dat_von, INTERVAL 1 DAY) AS INTEGER)) AS DATETIME)) AS
       NUMERIC), 1)
     WHEN v035.dat_von IS NULL
     THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v094.dat_von AS STRING), 1,
          20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
     ELSE ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v035.dat_von_wiedereintritt AS STRING)
          , 1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
     END, - 1) AS betriebszugehoerigkeit_bereinigt,
   COALESCE(CASE
     WHEN v094.dat_von IS NULL
     THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
     WHEN v035.dat_von IS NULL
     THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
     ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
     END, - 1) AS betriebszugehoerigkeit_bereinigt_in_tagen,
    CASE
    WHEN COALESCE(CASE
       WHEN v094.dat_von IS NULL
       THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v100.stichtag AS STRING),
            1, 20)), CAST(TIMESTAMP_SECONDS(CAST(DATE_ADD(v036.bzg_dat_von, INTERVAL 1 DAY) AS INTEGER)) AS DATETIME))
         AS NUMERIC), 1)
       WHEN v035.dat_von IS NULL
       THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v094.dat_von AS STRING), 1
            , 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
       ELSE ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v035.dat_von_wiedereintritt AS STRING)
            , 1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
       END, - 1) < - 1
    THEN 0
    WHEN COALESCE(CASE
       WHEN v094.dat_von IS NULL
       THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v100.stichtag AS STRING),
            1, 20)), CAST(TIMESTAMP_SECONDS(CAST(DATE_ADD(v036.bzg_dat_von, INTERVAL 1 DAY) AS INTEGER)) AS DATETIME))
         AS NUMERIC), 1)
       WHEN v035.dat_von IS NULL
       THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v094.dat_von AS STRING), 1
            , 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
       ELSE ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v035.dat_von_wiedereintritt AS STRING)
            , 1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
       END, - 1) = - 1
    THEN 1
    WHEN COALESCE(CASE
       WHEN v094.dat_von IS NULL
       THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v100.stichtag AS STRING),
            1, 20)), CAST(TIMESTAMP_SECONDS(CAST(DATE_ADD(v036.bzg_dat_von, INTERVAL 1 DAY) AS INTEGER)) AS DATETIME))
         AS NUMERIC), 1)
       WHEN v035.dat_von IS NULL
       THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v094.dat_von AS STRING), 1
            , 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
       ELSE ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v035.dat_von_wiedereintritt AS STRING)
            , 1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
       END, - 1) <= 3
    THEN 2
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v100.stichtag AS STRING)
             , 1, 20)), CAST(TIMESTAMP_SECONDS(CAST(DATE_ADD(v036.bzg_dat_von, INTERVAL 1 DAY) AS INTEGER)) AS DATETIME
            )) AS NUMERIC), 1)
        WHEN v035.dat_von IS NULL
        THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v094.dat_von AS STRING),
             1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
        ELSE ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v035.dat_von_wiedereintritt AS STRING)
             , 1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
        END, - 1) > 3 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v100.stichtag AS STRING)
             , 1, 20)), CAST(TIMESTAMP_SECONDS(CAST(DATE_ADD(v036.bzg_dat_von, INTERVAL 1 DAY) AS INTEGER)) AS DATETIME
            )) AS NUMERIC), 1)
        WHEN v035.dat_von IS NULL
        THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v094.dat_von AS STRING),
             1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
        ELSE ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v035.dat_von_wiedereintritt AS STRING)
             , 1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
        END, - 1) <= 6
    THEN 3
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v100.stichtag AS STRING)
             , 1, 20)), CAST(TIMESTAMP_SECONDS(CAST(DATE_ADD(v036.bzg_dat_von, INTERVAL 1 DAY) AS INTEGER)) AS DATETIME
            )) AS NUMERIC), 1)
        WHEN v035.dat_von IS NULL
        THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v094.dat_von AS STRING),
             1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
        ELSE ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v035.dat_von_wiedereintritt AS STRING)
             , 1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
        END, - 1) > 6 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v100.stichtag AS STRING)
             , 1, 20)), CAST(TIMESTAMP_SECONDS(CAST(DATE_ADD(v036.bzg_dat_von, INTERVAL 1 DAY) AS INTEGER)) AS DATETIME
            )) AS NUMERIC), 1)
        WHEN v035.dat_von IS NULL
        THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v094.dat_von AS STRING),
             1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
        ELSE ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v035.dat_von_wiedereintritt AS STRING)
             , 1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
        END, - 1) <= 12
    THEN 4
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v100.stichtag AS STRING)
             , 1, 20)), CAST(TIMESTAMP_SECONDS(CAST(DATE_ADD(v036.bzg_dat_von, INTERVAL 1 DAY) AS INTEGER)) AS DATETIME
            )) AS NUMERIC), 1)
        WHEN v035.dat_von IS NULL
        THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v094.dat_von AS STRING),
             1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
        ELSE ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v035.dat_von_wiedereintritt AS STRING)
             , 1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
        END, - 1) > 12 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v100.stichtag AS STRING)
             , 1, 20)), CAST(TIMESTAMP_SECONDS(CAST(DATE_ADD(v036.bzg_dat_von, INTERVAL 1 DAY) AS INTEGER)) AS DATETIME
            )) AS NUMERIC), 1)
        WHEN v035.dat_von IS NULL
        THEN ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v094.dat_von AS STRING),
             1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
        ELSE ROUND(CAST(SNOWCONVERT.PUBLIC.MONTHS_BETWEEN_UDF(PARSE_DATETIME('%F', SUBSTR(CAST(v035.dat_von_wiedereintritt AS STRING)
             , 1, 20)), PARSE_DATETIME('%F', SUBSTR(CAST(v036.bzg_dat_von AS STRING), 1, 20))) AS NUMERIC), 1)
        END, - 1) <= 36
    THEN 5
    ELSE 6
    END AS betriebszugehoerigkeit_cluster_sort_id,
    CASE
    WHEN v09.betriebszugehoerigkeit IN (0)
    THEN 0
    WHEN v09.betriebszugehoerigkeit IN (1, 2)
    THEN 1
    WHEN v09.betriebszugehoerigkeit IN (3, 4)
    THEN 2
    WHEN v09.betriebszugehoerigkeit IN (5, 6, 7, 8, 9)
    THEN 3
    WHEN v09.betriebszugehoerigkeit IN (10)
    THEN 4
    ELSE 5
    END AS betriebszugehoerigkeit_sort,
    CASE
    WHEN COALESCE(CASE
       WHEN v094.dat_von IS NULL
       THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
       WHEN v035.dat_von IS NULL
       THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
       ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
       END, - 1) <= 365
    THEN '<= 1 Jahr'
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) > 365 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) <= 1825
    THEN '> 1 - 5 Jahre'
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) > 1825 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) <= 3650
    THEN '> 5 - 10 Jahre'
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) > 3650 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) <= 5475
    THEN '> 10 - 15 Jahre'
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) > 5475 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) <= 7300
    THEN '> 15 - 20 Jahre'
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) > 7300 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) <= 10950
    THEN '> 20 - 30 Jahre'
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) > 10950 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) <= 14600
    THEN '> 30 - 40 Jahre'
    ELSE '> 40 Jahre'
    END AS betriebszugehoerigkeit_cluster_jahre,
    CASE
    WHEN COALESCE(CASE
       WHEN v094.dat_von IS NULL
       THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
       WHEN v035.dat_von IS NULL
       THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
       ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
       END, - 1) <= 365
    THEN 1
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) > 365 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) <= 1825
    THEN 2
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) > 1825 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) <= 3650
    THEN 3
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) > 3650 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) <= 5475
    THEN 4
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) > 5475 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) <= 7300
    THEN 5
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) > 7300 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) <= 10950
    THEN 6
    WHEN COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) > 10950 AND COALESCE(CASE
        WHEN v094.dat_von IS NULL
        THEN DATE_DIFF(v100.stichtag, v036.bzg_dat_von, DAY) + 1
        WHEN v035.dat_von IS NULL
        THEN DATE_DIFF(v094.dat_von, v036.bzg_dat_von, DAY)
        ELSE DATE_DIFF(v035.dat_von_wiedereintritt, v036.bzg_dat_von, DAY)
        END, - 1) <= 14600
    THEN 7
    ELSE 8
    END AS betriebszugehoerigkeit_cluster_jahre_sort,
   v07.land_id AS nationalitaet,
   v09.err_dat,
   v09.vertragsende,
   v09.anz_mon_vertragsende,
   v01.krank_tage_arbeitstage,
   v01.anz_arbeits_unfall,
   v01.sonstige_abwesenheit_fg,
   v01.pflege_fg,
   v01.krankheit_unfall_fg,
   v01.langzeit_abwesenheit_tage,
   v01.langzeit_abwesenheit_tage_kum,
   v01.langzeit_min_dat,
   v01.langzeit_abwesenheit_grund,
   v01.stichtag_fg,
   v01.dat_letzte_abwesenheit,
   COALESCE(DATE_SUB(v094.dat_von, INTERVAL 1 DAY), DATE('9999-12-31')) AS austrittsdatum,
   COALESCE(v033.dat_von, v035.dat_von, v036.dat_von, DATE('1900-01-01')) AS eintrittsdatum,
    CASE
    WHEN v094.mitarbeiter_id IS NOT NULL
    THEN 1
    ELSE 0
    END AS austritt_alles_fg,
    CASE
    WHEN v095.mitarbeiter_id IS NOT NULL
    THEN 1
    ELSE 0
    END AS austritt_919899_fg,
    CASE
    WHEN v097.mitarbeiter_id IS NOT NULL
    THEN v097.anzahl_lohnart
    ELSE 0
    END AS azubi_cz_sk_hr_stunden,
   ma_abw.arbeitsunfall_fg,
   ma_abw_au_folge.arbeitsunfall_folgeabw_fg,
   ma_abw.arbeitsunfall_anzahl
  FROM kfl_production_dbp_view.v_mitarbeiterbew_2 AS v01
   LEFT JOIN kfl_production_dbp_view.v_mitarbeiterbew_2 AS mbew ON v01.mandant_id = mbew.mandant_id AND mbew.kjmo = ROUND(CAST(FORMAT_DATE('%Y%m', IF(PARSE_DATE('%Y%m', SAFE_CAST(v01.kjmo as STRING)) = LAST_DAY(PARSE_DATE('%Y%m', SAFE_CAST(v01.kjmo as STRING))), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m',
             SAFE_CAST(v01.kjmo as STRING)), INTERVAL - 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(v01.kjmo as STRING)), INTERVAL - 1 MONTH))) AS BIGNUMERIC)
       , 0) AND v01.mitarbeiter_id = mbew.mitarbeiter_id
   INNER JOIN kfl_production_dbp_view.v_monat_2 AS v08 ON v01.kjmo = v08.kjmo
   LEFT JOIN kfl_production_dbp_view.v_mitarbeiterbew_2 AS v0111 ON v01.mitarbeiter_id = v0111.mitarbeiter_id AND v01.mandant_id
       = v0111.mandant_id AND v0111.kjmo = ROUND(CAST(FORMAT_DATE('%Y%m', IF(PARSE_DATE('%Y%m', SAFE_CAST(v01.kjmo as STRING)) = LAST_DAY(PARSE_DATE('%Y%m', SAFE_CAST(v01.kjmo as STRING))), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m', SAFE_CAST(v01.kjmo as STRING)), INTERVAL - 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m'
           , SAFE_CAST(v01.kjmo as STRING)), INTERVAL - 1 MONTH))) AS BIGNUMERIC), 0)
   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     mitarbeiter_gruppe_id
    FROM kfl_production_dbp_msi_view_shr.mv_ma_gruppe_zu_per_2 AS v0
    GROUP BY mandant_id,
     mitarbeiter_gruppe_id,
     mitarbeiter_id,
     kjmo) AS v101 ON v01.mitarbeiter_id = v101.mitarbeiter_id AND v01.mandant_id = v101.mandant_id AND v01.kjmo = v101
     .kjmo -- Ermittlung MA Kreis

   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     mitarbeiter_kreis_id
    FROM kfl_production_dbp_msi_view_shr.mv_ma_kreis_zu_per_2 AS v0
    GROUP BY mandant_id,
     mitarbeiter_kreis_id,
     mitarbeiter_id,
     kjmo) AS v102 ON v01.mitarbeiter_id = v102.mitarbeiter_id AND v01.mandant_id = v102.mandant_id AND v01.kjmo = v102
     .kjmo -- Ermittlung MA Kostenstelle

   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     kostenstelle_id
    FROM kfl_production_dbp_msi_view_shr.mv_ma_kostenstelle_zu_per_2 AS v0
    WHERE haupt_kst_fg = 1
    GROUP BY mandant_id,
     mitarbeiter_id,
     kjmo,
     kostenstelle_id) AS v103 ON v01.mitarbeiter_id = v103.mitarbeiter_id AND v01.mandant_id = v103.mandant_id AND v01.kjmo
      = v103.kjmo -- Hier enden die neu eingefügten Felder von mmzy2302

   LEFT JOIN kfl_production_dbp_view.v_ma_personalbereich_zu_per_2 AS v020 ON v01.mitarbeiter_id = v020.mitarbeiter_id AND
      v01.mandant_id = v020.mandant_id AND v01.kjmo = v020.kjmo
   LEFT JOIN kfl_production_dbp_msi_view_shr.mv_l_ma_variable_2 AS v03 ON v020.buchungskreis_id = v03.buchungskreis_id AND
      v020.mandant_id = v03.mandant_id AND v020.kjmo = v03.kjmo
   LEFT JOIN kfl_production_dbp_view.v_ma_lohnart_zu_per_2 AS v04 ON v01.mitarbeiter_id = v04.mitarbeiter_id AND v01.mandant_id
        = v04.mandant_id AND v01.kjmo = v04.kjmo AND v04.lohnart_id = '7723'
   LEFT JOIN kfl_production_dbp_msi_view_shr.mv_shr_datenfreigabe_2 AS v06 ON v01.mandant_id = v06.mandant_id AND v01.kjmo
      = v06.kjmo -- Berechnung Alter des Mitarbeiters des jeweiligen Jahres

   INNER JOIN kfl_production_dbp_view.v_hr_mitarbeiter_2 AS v07 ON v01.mitarbeiter_id = v07.mitarbeiter_id AND v01.mandant_id
      = v07.mandant_id -- Berechnung Betriebszugehörigkeit des Mitarbeiters und Vertragsende / Kündigung

   INNER JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     MAX(CAST(kjmo / 100 AS BIGNUMERIC) - EXTRACT(YEAR FROM dat_von)) AS betriebszugehoerigkeit,
     MAX(PARSE_DATE('%Y.%m.%d', SUBSTR(CAST(LEFT(SUBSTR(CAST(kjmo / 100 AS STRING), 1, 11), 4) AS STRING), 1, 4) || '.'
         || CAST(CAST(MOD(kjmo, 100) AS BIGNUMERIC) AS STRING) || '.01')) AS err_dat,
     MAX(CASE
       WHEN datumsart_id = '-1'
       THEN dat_von
       ELSE NULL
       END) AS vertragsende,
     MAX(TIMESTAMP_DIFF(CASE
        WHEN datumsart_id = '-1'
        THEN dat_von
        ELSE NULL
        END, PARSE_DATE('%Y.%m.%d', SUBSTR(CAST(LEFT(SUBSTR(CAST(kjmo / 100 AS STRING), 1, 11), 4) AS STRING), 1, 4) ||
           '.' || CAST(CAST(MOD(kjmo, 100) AS BIGNUMERIC) AS STRING) || '.01'), MONTH)) AS anz_mon_vertragsende
    FROM kfl_production_dbp_view.v_ma_datumsart_zu_per_2 AS v100
    WHERE datumsart_id IN ('02', '-1')
     -- Einschraenkung auf Datum kann raus, da fuer jeden Mandanten dAS Highdate mitgenommen werden soll.

     /* AND 
     ( TO_DATE(v100.dat_von) < '2200-01-01'
       -- da bei CZ, SK & BG auch der Datumswert '9999-12-31' mitgenommen werden soll. 
     -- Nur bei Dat_von mit der Datumsart_id = -1 kommt dies vor. 
     OR v100.mandant_id IN (2,5,8) ) */
     -- GROUP BY    v100.mandant_id
 -- ,v100.mitarbeiter_id
 -- ,v100.kjmo

    GROUP BY mandant_id,
     mitarbeiter_id,
     kjmo) AS v09 ON v01.mitarbeiter_id = v09.mitarbeiter_id AND v01.mandant_id = v09.mandant_id AND v01.kjmo = v09.kjmo
     -- Berechnung Austrittsdatum

   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     dat_von
    FROM kfl_production_dbp_view.v_ma_datumsart_zu_per_2 AS v093
    WHERE datumsart_id IN ('05')) AS v093 ON v01.mitarbeiter_id = v093.mitarbeiter_id AND v01.mandant_id = v093.mandant_id
       AND v01.kjmo = v093.kjmo -- Berechnung Eintrittsdatum 01

   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     MIN(dat_von) AS dat_von
    FROM kfl_production_dbp_view.v_ma_hr_massnahme_zu_per_2 AS v033
    WHERE hr_massnahme_id = '01'
    GROUP BY mandant_id,
     mitarbeiter_id,
     kjmo) AS v033 ON v01.mitarbeiter_id = v033.mitarbeiter_id AND v01.mandant_id = v033.mandant_id AND v01.kjmo = v033
     .kjmo -- Berechnung Eintrittsdatum 02

   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     MIN(dat_von) AS dat_von,
     MAX(dat_von) AS dat_von_wiedereintritt
    FROM kfl_production_dbp_view.v_ma_hr_massnahme_zu_per_2 AS v035
    WHERE hr_massnahme_id = '02'
    GROUP BY mandant_id,
     mitarbeiter_id,
     kjmo) AS v035 ON v01.mitarbeiter_id = v035.mitarbeiter_id AND v01.mandant_id = v035.mandant_id AND v01.kjmo = v035
     .kjmo -- Berechnung Eintrittsdatum 03
 -- Änderung der Berechnung der BZG START

   LEFT JOIN eintrittsdatum_03 AS v036 ON v01.mitarbeiter_id = v036.mitarbeiter_id AND v01.mandant_id = v036.mandant_id
    AND v01.kjmo = v036.kjmo -- Ermittlung Austrittsdatum

   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     MIN(dat_von) AS dat_von,
     MAX(dat_von) AS dat_von_wiedereintritt
    FROM kfl_production_dbp_view.v_ma_hr_massnahme_zu_per_2 AS v0
    WHERE hr_massnahme_id = '04'
    GROUP BY mandant_id,
     mitarbeiter_id,
     kjmo) AS v094 ON v01.mitarbeiter_id = v094.mitarbeiter_id AND v01.mandant_id = v094.mandant_id AND v01.kjmo = v094
     .kjmo -- Austritt wegen Tod, Rente, Wechsel: löschbar nach FE-Fertigstellung Moldau

   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo
    FROM kfl_production_dbp_view.v_ma_hr_massnahme_zu_per_2 AS v095
    WHERE hr_massnahme_id = '04'
     AND hr_massnahme_grund_id IN ('91', '98', '99')
    GROUP BY mandant_id,
     mitarbeiter_id,
     kjmo) AS v095 ON v01.mitarbeiter_id = v095.mitarbeiter_id AND v01.mandant_id = v095.mandant_id AND v01.kjmo = v095
     .kjmo -- Ende löschbar
 -- comment FDS, initions: dbp_view.v_ma_kostenstelle_lohnart_zu_per_2 wird ausgelagert

     /* LEFT JOIN
(SELECT v096.mandant_id,
v096.mitarbeiter_id,
v096.kjmo,
SUM(v096.anzahl_lohnart) AS anzahl_lohnart
FROM KFL_PRODUCTION.dbp_view.v_ma_kostenstelle_lohnart_zu_per_2 v096

WHERE (v096.mandant_id = 2 AND lohnart_id IN ('3001', '3004')) OR (v096.mandant_id = 5 AND lohnart_id IN ('3001'))
GROUP BY
v096.mandant_id,
v096.mitarbeiter_id,
v096.kjmo)
v096
ON  v01.mitarbeiter_id = v096.mitarbeiter_id
AND v01.mandant_id = v096.mandant_idv01.mandant_id
AND v01.kjmo = v096.kjmo */
     
   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     SUM(anzahl_lohnart) AS anzahl_lohnart
    FROM kfl_production_dbp_view.v_ma_kostenstelle_lohnart_zu_per_2 AS v097
    WHERE mandant_id = 2 AND lohnart_id IN ('1072')
     OR mandant_id = 6 AND lohnart_id IN ('1071')
    GROUP BY mandant_id,
     mitarbeiter_id,
     kjmo) AS v097 ON v01.mitarbeiter_id = v097.mitarbeiter_id AND v01.mandant_id = v097.mandant_id AND v01.kjmo = v097
     .kjmo -- Sonderregelung HR, weil über SAP falsche Werte kommen

   LEFT JOIN (SELECT mandant_id,
     kjmo_von,
     kjmo_bis,
     anz_stunden_von,
     anz_stunden_bis,
     SUM(arbeitszeit_anteil) AS arbeitszeit_anteil_hr
    FROM kfl_production_dbp_view.v_shr_arbeitszeit_anteil_mapping_2 AS v099
    GROUP BY mandant_id,
     kjmo_bis,
     anz_stunden_bis,
     kjmo_von,
     anz_stunden_von) AS v099 ON v01.mandant_id = v099.mandant_id AND v01.kjmo BETWEEN v099.kjmo_von AND v099.kjmo_bis
    AND v01.soll_stunden_monat BETWEEN v099.anz_stunden_von AND v099.anz_stunden_bis
   LEFT JOIN (SELECT kjmo,
     MAX(dat) AS stichtag
    FROM kfl_production_dbp_view.v_tag_2 AS v100
    GROUP BY kjmo) AS v100 ON v01.kjmo = v100.kjmo -- Einführung Flag Arbeitsunfall

    -- Vormonatslogik: EIN Arbeitsunfall mit gleicher Abwesenheit im Folgemonat zählt nur als Arbeitsunfall, wenn der > 3Tage Ausfall

    
   LEFT JOIN (SELECT DISTINCT mandant_id,
     mitarbeiter_id,
     kjmo_dat_von AS kjmo,
     arbeitsunfall_fg,
     arbeitsunfall_fg AS arbeitsunfall_anzahl
    FROM (SELECT mandant_id,
       mitarbeiter_id,
       kjmo,
       EXTRACT(YEAR FROM dat_von) AS jahr,
       TRIM(CAST(EXTRACT(MONTH FROM dat_von) AS STRING FORMAT '00')) AS monat_2,
       ROUND(CAST(TRIM(SUBSTR(CAST(EXTRACT(YEAR FROM dat_von) AS STRING), 1, 19)) || TRIM(TRIM(CAST(EXTRACT(MONTH FROM dat_von) AS STRING FORMAT '00')
            )) AS BIGNUMERIC), 0) AS kjmo_dat_von,
       dat_von,
        (SELECT MAX(dat_bis)
        FROM kfl_production_dbp_view.v_ma_abwesenh_zu_per_2 AS v2
        WHERE mandant_id = ma_abw.mandant_id
         AND mitarbeiter_id = ma_abw.mitarbeiter_id
         AND (ma_abw.dat_von > dat_von OR ma_abw.kjmo > kjmo)
         AND ma_abw.abwesenheit_id = abwesenheit_id) AS dat_bis_vorperiode,
        CASE
        WHEN COALESCE(DATE_DIFF(dat_von, (SELECT MAX(dat_bis)
            FROM kfl_production_dbp_view.v_ma_abwesenh_zu_per_2 AS v2
            WHERE mandant_id = ma_abw.mandant_id
             AND mitarbeiter_id = ma_abw.mitarbeiter_id
             AND (ma_abw.dat_von > dat_von OR ma_abw.kjmo > kjmo)
             AND ma_abw.abwesenheit_id = abwesenheit_id), DAY), 1000) <= 3
        THEN 0
        WHEN mandant_id = 2 AND abwesenheit_id = '0210' OR mandant_id = 3 AND abwesenheit_id IN ('0210', '9420') OR
               mandant_id = 4 AND abwesenheit_id IN ('0240', '9432') OR mandant_id = 5 AND abwesenheit_id = '0410' OR
             mandant_id = 6 AND abwesenheit_id IN ('9015', '9413') OR mandant_id = 7 AND abwesenheit_id IN ('0240',
             '9429', '9432', '9434') OR mandant_id = 8 AND abwesenheit_id = '0270'
        THEN 1
        ELSE 0
        END AS arbeitsunfall_fg
      FROM kfl_production_dbp_view.v_ma_abwesenh_zu_per_2 AS ma_abw
      GROUP BY mandant_id,
       mitarbeiter_id,
       kjmo,
       jahr,
       monat_2,
       kjmo_dat_von,
       dat_von,
       dat_bis_vorperiode,
       arbeitsunfall_fg
      HAVING arbeitsunfall_fg = 1 /* OR arbeitsunfall_folgeabw_fg = 1 */) AS t45) AS ma_abw ON v01.kjmo = ma_abw.kjmo
     AND v01.mitarbeiter_id = ma_abw.mitarbeiter_id AND v01.mandant_id = ma_abw.mandant_id
     -- Auslagerung Folgeabwesenheit, da hier über dAS 'normale'' kjmo gejoint werden soll

   LEFT JOIN (SELECT mandant_id,
     mitarbeiter_id,
     kjmo,
     MAX(CASE
       WHEN mandant_id = 2 AND abwesenheit_id IN ('0210', '0211', '0215') OR mandant_id = 3 AND abwesenheit_id IN ('0210'
                , '9420') OR mandant_id = 4 AND abwesenheit_id IN ('0240', '9432') OR mandant_id = 5 AND abwesenheit_id
             IN ('0410', '0411', '0415') OR mandant_id = 6 AND abwesenheit_id IN ('9015', '9016', '9413') OR mandant_id
           = 7 AND abwesenheit_id IN ('0240', '9429', '9432', '9434') OR mandant_id = 8 AND abwesenheit_id IN ('0270',
           '0271')
       THEN 1
       ELSE 0
       END) AS arbeitsunfall_folgeabw_fg
    FROM kfl_production_dbp_view.v_ma_abwesenh_zu_per_2 AS ma_abw
    GROUP BY mandant_id,
     mitarbeiter_id,
     kjmo
    HAVING arbeitsunfall_folgeabw_fg = 1) AS ma_abw_au_folge ON v01.kjmo = ma_abw_au_folge.kjmo AND v01.mitarbeiter_id =
      ma_abw_au_folge.mitarbeiter_id AND v01.mandant_id = ma_abw_au_folge.mandant_id
   LEFT JOIN (SELECT mandant_id,
     krk_id,
     kjmo,
     kostenstelle_ebene1_id,
     kostenstelle_ebene2_id,
     kostenstelle_ebene3_id,
     kostenstelle_ebene4_id,
     kostenstelle_ebene5_id,
     kostenstelle_ebene6_id,
     kostenstelle_ebene7_id,
     kostenstelle_ebene8_id,
     kostenstelle_ebene9_id,
     kostenstelle_ebene10_id,
     kostenstelle_ebene11_id,
     kostenstelle_ebene12_id,
     kostenstelle_ebene13_id,
     kostenstelle_ebene14_id,
     kostenstelle_ebene15_id,
     kostenstelle_ebene1_bez,
     kostenstelle_ebene2_bez,
     kostenstelle_ebene3_bez,
     kostenstelle_ebene4_bez,
     kostenstelle_ebene5_bez,
     kostenstelle_ebene6_bez,
     kostenstelle_ebene7_bez,
     kostenstelle_ebene8_bez,
     kostenstelle_ebene9_bez,
     kostenstelle_ebene10_bez,
     kostenstelle_ebene11_bez,
     kostenstelle_ebene12_bez,
     kostenstelle_ebene13_bez,
     kostenstelle_ebene14_bez,
     kostenstelle_ebene15_bez
    FROM kfl_production_dbp_view.v_kostenstelle_hierarchie_2
    WHERE kjmo = (SELECT MAX(kjmo)
       FROM kfl_production_dbp_view.v_kostenstelle_hierarchie_2)
     AND kostenstelle_ebene1_id IN ('KBG01', 'KDE01', 'KCZ01', 'KHR01', 'KPL01', 'KRO01', 'KSK01', 'KMD01')) AS v2 ON
     v01.mandant_id = v2.mandant_id AND v103.kostenstelle_id -- NSR0292396 Ausblenden von Zeiträumen
 = v2.kostenstelle_ebene15_id
     
  WHERE v01.kjmo > 201510);