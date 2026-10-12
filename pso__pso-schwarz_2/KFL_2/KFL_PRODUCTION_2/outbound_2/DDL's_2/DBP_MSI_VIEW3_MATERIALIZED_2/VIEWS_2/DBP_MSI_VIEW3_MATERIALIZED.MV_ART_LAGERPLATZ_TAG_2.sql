
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_art_lagerplatz_tag_2 (art_id, mandant_id, system_id,
wup_id, nb_id, lagernummer_id, lagertyp_id, lagerplatz_id, dat, lagerplatz_loesch_kz, mlgt_fg, bestand_kz, bestand_kz_11
, bestand_kz_22, bestand_kz_33, bestand_kz_44, bestand_kz_1, bestand_kz_2, bestand_kz_3, bestand_kz_4, bestand_kz_5,
bestand_kz_6, bestand_kz_7, bestand_kz_8, bestand_kz_9, bestand_kz_10, bestand_kz_99, bestand_kz_12, bestand_kz_13,
bestand_kz_14, bestand_kz_15, bestand_kz_16, bestand_kz_17, bestand_kz_18) AS SELECT art_id,
 mandant_id,
 system_id,
 wup_id,
 nb_id,
 lagernummer_id,
 lagertyp_id,
 lagerplatz_id,
 dat,
 lagerplatz_loesch_kz,
 mlgt_fg,
 bestand_kz,
  CASE
  WHEN bestand_kz = 11
  THEN 1
  ELSE 0
  END AS bestand_kz_11,
  CASE
  WHEN bestand_kz = 22
  THEN 1
  ELSE 0
  END AS bestand_kz_22,
  CASE
  WHEN bestand_kz = 33
  THEN 1
  ELSE 0
  END AS bestand_kz_33,
  CASE
  WHEN bestand_kz = 44
  THEN 1
  ELSE 0
  END AS bestand_kz_44,
   CASE
   WHEN bestand_kz = 1
   THEN 1
   ELSE 0
   END + CASE
   WHEN bestand_kz = 11
   THEN 1
   ELSE 0
   END AS bestand_kz_1,
   CASE
   WHEN bestand_kz = 2
   THEN 1
   ELSE 0
   END + CASE
   WHEN bestand_kz = 22
   THEN 1
   ELSE 0
   END AS bestand_kz_2,
   CASE
   WHEN bestand_kz = 3
   THEN 1
   ELSE 0
   END + CASE
   WHEN bestand_kz = 33
   THEN 1
   ELSE 0
   END AS bestand_kz_3,
   CASE
   WHEN bestand_kz = 4
   THEN 1
   ELSE 0
   END + CASE
   WHEN bestand_kz = 44
   THEN 1
   ELSE 0
   END AS bestand_kz_4,
  CASE
  WHEN bestand_kz = 5
  THEN 1
  ELSE 0
  END AS bestand_kz_5,
  CASE
  WHEN bestand_kz = 6
  THEN 1
  ELSE 0
  END AS bestand_kz_6,
  CASE
  WHEN bestand_kz = 7
  THEN 1
  ELSE 0
  END AS bestand_kz_7,
 anzahl_quant AS bestand_kz_8,
      CASE
      WHEN bestand_kz = 1
      THEN 1
      ELSE 0
      END + CASE
      WHEN bestand_kz = 11
      THEN 1
      ELSE 0
      END + (CASE
       WHEN bestand_kz = 2
       THEN 1
       ELSE 0
       END + CASE
       WHEN bestand_kz = 22
       THEN 1
       ELSE 0
       END) + (CASE
      WHEN bestand_kz = 3
      THEN 1
      ELSE 0
      END + CASE
      WHEN bestand_kz = 33
      THEN 1
      ELSE 0
      END) + (CASE
     WHEN bestand_kz = 4
     THEN 1
     ELSE 0
     END + CASE
     WHEN bestand_kz = 44
     THEN 1
     ELSE 0
     END) AS bestand_kz_9,
    CASE
    WHEN bestand_kz = 5
    THEN 1
    ELSE 0
    END + CASE
    WHEN bestand_kz = 6
    THEN 1
    ELSE 0
    END + CASE
   WHEN bestand_kz = 7
   THEN 1
   ELSE 0
   END AS bestand_kz_10,
     CASE
     WHEN bestand_kz = 11
     THEN 1
     ELSE 0
     END + CASE
     WHEN bestand_kz = 22
     THEN 1
     ELSE 0
     END + CASE
    WHEN bestand_kz = 33
    THEN 1
    ELSE 0
    END + CASE
   WHEN bestand_kz = 44
   THEN 1
   ELSE 0
   END AS bestand_kz_99,
   CASE
   WHEN bestand_kz = 12
   THEN 1
   ELSE 0
   END + CASE
   WHEN lagertyp_id = 'RH1'
   THEN CASE
    WHEN bestand_kz = 5
    THEN 1
    ELSE 0
    END
   ELSE 0
   END AS bestand_kz_12,
   CASE
   WHEN bestand_kz = 13
   THEN 1
   ELSE 0
   END + CASE
   WHEN lagertyp_id = 'RH1'
   THEN CASE
    WHEN bestand_kz = 6
    THEN 1
    ELSE 0
    END
   ELSE 0
   END AS bestand_kz_13,
    CASE
    WHEN bestand_kz = 12
    THEN 1
    ELSE 0
    END + CASE
    WHEN lagertyp_id = 'RH1'
    THEN CASE
     WHEN bestand_kz = 5
     THEN 1
     ELSE 0
     END
    ELSE 0
    END + (CASE
     WHEN bestand_kz = 13
     THEN 1
     ELSE 0
     END + CASE
     WHEN lagertyp_id = 'RH1'
     THEN CASE
      WHEN bestand_kz = 6
      THEN 1
      ELSE 0
      END
     ELSE 0
     END) AS bestand_kz_14,
  CASE
  WHEN bestand_kz = 15
  THEN 1
  ELSE 0
  END AS bestand_kz_15,
  CASE
  WHEN bestand_kz = 16
  THEN 1
  ELSE 0
  END AS bestand_kz_16,
  CASE
  WHEN bestand_kz = 17
  THEN 1
  ELSE 0
  END AS bestand_kz_17,
  CASE
  WHEN bestand_kz = 18
  THEN 1
  ELSE 0
  END AS bestand_kz_18
FROM kfl_production_dbp_view.v_art_lagerplatz_tag_2
WHERE EXTRACT(YEAR FROM dat) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;