CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_paletten_kontrolle_1 (mandant_id, system_id, nb_id, wup_id,
art_id, handling_unit_id, fehler_lfd_nr, waqfk_fehler_id, waqfk_kennziffer_id, zlv_merkmal, lagernummer_id,
menge_waqfk_kolli_soll_, menge_waqfk_kolli_ist_, anzahl_fehler_kolli, dat_quittierung, dat_kontrolle, sap_user_benutzer
, kunde_id_neu, sap_user_kontrolle, mandant_id_kunde, dat_lief_soll, anzahl_gepruefte_paletten, anzahl_waqfk_kunden,
anzahl_waqfk_kommisionierer, anzahl_waqfk_fehler, anzahl_waqfk_fehler1, anzahl_waqfk_fehler2, anzahl_waqfk_fehler3,
anzahl_waqfk_fehler4, anzahl_waqfk_fehler5, anzahl_ok_paletten, wrg_id, wrg_typ_id, vk_netto_waqfk_soll,
vk_netto_waqfk_ist, vk_netto_waqfk_fehler_abs, vk_netto_waqfk_fehler_sal, menge_waqfk_kolli_soll, menge_waqfk_kolli_ist
, kunde_id) AS SELECT V01.mandant_id,
 V01.system_id,
 V01.nb_id,
 V01.wup_id,
 V01.art_id,
 V01.handling_unit_id,
 V01.fehler_lfd_nr,
 V01.waqfk_fehler_id,
 V01.waqfk_kennziffer_id,
 V01.zlv_merkmal,
 MIN(V01.lagernummer_id) AS lagernummer_id,
  CASE
  WHEN V01.zlv_merkmal IN ('A', 'E', 'L')
  THEN V01.menge_waqfk_kolli_soll
  ELSE 0
  END AS menge_waqfk_kolli_soll_,
  CASE
  WHEN V01.zlv_merkmal IN ('A', 'E', 'L')
  THEN V01.menge_waqfk_kolli_ist
  ELSE 0
  END AS menge_waqfk_kolli_ist_,
 ABS(CASE
    WHEN V01.zlv_merkmal IN ('A', 'E')
    THEN V01.menge_waqfk_kolli_soll
    ELSE 0
    END - CASE
    WHEN V01.zlv_merkmal IN ('A', 'E')
    THEN V01.menge_waqfk_kolli_ist
    ELSE 0
    END) AS anzahl_fehler_kolli,
 V01.dat_quittierung,
 V01.dat_kontrolle,
 MIN(V01.sap_user_benutzer) AS sap_user_benutzer,
 MIN(V05.aktuell_wup_id) AS kunde_id_neu,
 MIN(V01.sap_user_kontrolle) AS sap_user_kontrolle,
  CASE
  WHEN V01.mandant_id_kunde IS NULL OR V01.mandant_id_kunde = 0
  THEN V01.mandant_id
  ELSE V01.mandant_id_kunde
  END AS mandant_id_kunde,
 V01.dat_lief_soll,
  CASE
  WHEN V01.handling_unit_id - (SUM(V01.handling_unit_id) OVER (PARTITION BY V01.mandant_id, V01.lagernummer_id, V01.handling_unit_id
         , V01.dat_lief_soll, V03.wrg_typ_id ORDER BY V01.art_id NULLS LAST, V01.waqfk_fehler_id NULLS LAST ROWS BETWEEN
       1 PRECEDING AND 1 PRECEDING)) <> 0 OR (SUM(V01.handling_unit_id) OVER (PARTITION BY V01.mandant_id, V01.lagernummer_id
       , V01.handling_unit_id, V01.dat_lief_soll, V03.wrg_typ_id ORDER BY V01.art_id NULLS LAST, V01.waqfk_fehler_id
       NULLS LAST ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)) IS NULL
  THEN 1
  ELSE 0
  END AS anzahl_gepruefte_paletten,
  CASE
  WHEN CAST(MIN(V01.kunde_id) AS FLOAT64) - (SUM(ROUND(CAST(V01.kunde_id AS BIGNUMERIC), 0)) OVER (PARTITION BY V01.mandant_id
        , V01.lagernummer_id, V01.kunde_id, V01.dat_lief_soll, V03.wrg_typ_id ORDER BY 1 NULLS LAST ROWS BETWEEN 1
      PRECEDING AND 1 PRECEDING)) <> 0
  THEN 1
  ELSE 0
  END AS anzahl_waqfk_kunden,
  CASE
  WHEN MIN(V01.sap_user_benutzer) <> (MAX(V01.sap_user_benutzer) OVER (PARTITION BY V01.mandant_id, V01.lagernummer_id,
        V01.dat_lief_soll, V03.wrg_typ_id ORDER BY V01.sap_user_benutzer NULLS LAST ROWS BETWEEN 1 PRECEDING AND 1
      PRECEDING)) OR (MAX(V01.sap_user_benutzer) OVER (PARTITION BY V01.mandant_id, V01.lagernummer_id, V01.dat_lief_soll
       , V03.wrg_typ_id ORDER BY V01.sap_user_benutzer NULLS LAST ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)) IS NULL
  THEN 1
  ELSE 0
  END AS anzahl_waqfk_kommisionierer,
 1 AS anzahl_waqfk_fehler,
  CASE
  WHEN V01.waqfk_fehler_id = 1
  THEN 1
  ELSE 0
  END AS anzahl_waqfk_fehler1,
  CASE
  WHEN V01.waqfk_fehler_id = 2
  THEN 1
  ELSE 0
  END AS anzahl_waqfk_fehler2,
  CASE
  WHEN V01.waqfk_fehler_id = 3
  THEN 1
  ELSE 0
  END AS anzahl_waqfk_fehler3,
  CASE
  WHEN V01.waqfk_fehler_id = 4
  THEN 1
  ELSE 0
  END AS anzahl_waqfk_fehler4,
  CASE
  WHEN V01.waqfk_fehler_id = 5
  THEN 1
  ELSE 0
  END AS anzahl_waqfk_fehler5,
  CASE
  WHEN CASE
    WHEN V01.handling_unit_id - (SUM(V01.handling_unit_id) OVER (PARTITION BY V01.mandant_id, V01.lagernummer_id, V01.handling_unit_id
           , V01.dat_lief_soll, V03.wrg_typ_id ORDER BY V01.art_id NULLS LAST, V01.waqfk_fehler_id NULLS LAST
         ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)) <> 0 OR (SUM(V01.handling_unit_id) OVER (PARTITION BY V01.mandant_id
         , V01.lagernummer_id, V01.handling_unit_id, V01.dat_lief_soll, V03.wrg_typ_id ORDER BY V01.art_id NULLS LAST,
         V01.waqfk_fehler_id NULLS LAST ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)) IS NULL
    THEN 1
    ELSE 0
    END = 1
  THEN CASE
   WHEN (SUM(V01.waqfk_fehler_id) OVER (PARTITION BY V01.mandant_id, V01.lagernummer_id, V01.handling_unit_id, V01.dat_lief_soll
        , V03.wrg_typ_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
   THEN 1
   ELSE 0
   END
  ELSE 0
  END AS anzahl_ok_paletten,
 MIN(V03.wrg_id) AS wrg_id,
 V03.wrg_typ_id,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN CASE
    WHEN V01.zlv_merkmal IN ('A', 'E')
    THEN V01.betrag_vk_netto_soll
    ELSE 0
    END * V02.umrechnungskurs
  ELSE CASE
   WHEN V01.zlv_merkmal IN ('A', 'E')
   THEN V01.betrag_vk_netto_soll
   ELSE 0
   END
  END AS vk_netto_waqfk_soll,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN CASE
    WHEN V01.zlv_merkmal IN ('A', 'E')
    THEN V01.betrag_vk_netto_ist
    ELSE 0
    END * V02.umrechnungskurs
  ELSE CASE
   WHEN V01.zlv_merkmal IN ('A', 'E')
   THEN V01.betrag_vk_netto_ist
   ELSE 0
   END
  END AS vk_netto_waqfk_ist,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN CASE
    WHEN V01.zlv_merkmal IN ('A', 'E')
    THEN ABS(V01.betrag_vk_netto_ist - V01.betrag_vk_netto_soll)
    ELSE 0
    END * V02.umrechnungskurs
  ELSE CASE
   WHEN V01.zlv_merkmal IN ('A', 'E')
   THEN ABS(V01.betrag_vk_netto_ist - V01.betrag_vk_netto_soll)
   ELSE 0
   END
  END AS vk_netto_waqfk_fehler_abs,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN CASE
    WHEN V01.zlv_merkmal IN ('A', 'E')
    THEN V01.betrag_vk_netto_ist - V01.betrag_vk_netto_soll
    ELSE 0
    END * V02.umrechnungskurs
  ELSE CASE
   WHEN V01.zlv_merkmal IN ('A', 'E')
   THEN V01.betrag_vk_netto_ist - V01.betrag_vk_netto_soll
   ELSE 0
   END
  END AS vk_netto_waqfk_fehler_sal,
 V01.menge_waqfk_kolli_soll,
 V01.menge_waqfk_kolli_ist,
 MIN(V01.kunde_id) AS kunde_id
FROM kfl_production_dbp_view.v_paletten_kontrolle_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON V05.mandant_id = CASE
     WHEN V01.mandant_id_kunde IS NULL OR V01.mandant_id_kunde = 0
     THEN V01.mandant_id
     ELSE V01.mandant_id_kunde
     END AND V05.wup_id = CASE
     WHEN SAFE_CAST(ROUND(CAST(V01.kunde_id AS FLOAT64)) AS INTEGER) = 0
     THEN NULL
     ELSE SAFE_CAST(ROUND(CAST(V01.kunde_id AS FLOAT64)) AS INTEGER)
     END AND (V05.nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
 INNER JOIN kfl_production_dbp_msi_view3.mv_kurs_1 AS V02 ON V01.wrg_id = V02.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS V03 ON V01.mandant_id = V03.mandant_id
WHERE ROUND(SAFE_CAST(V01.kunde_id AS BIGNUMERIC), 0) IS NOT NULL
GROUP BY V01.mandant_id,
 V01.system_id,
 V01.nb_id,
 V01.wup_id,
 V01.art_id,
 V01.handling_unit_id,
 V01.fehler_lfd_nr,
 V01.waqfk_fehler_id,
 V01.waqfk_kennziffer_id,
 V01.zlv_merkmal,
 V01.lagernummer_id,
 V01.menge_waqfk_kolli_soll,
 V01.menge_waqfk_kolli_ist,
 V01.dat_quittierung,
 V01.dat_kontrolle,
 V01.sap_user_benutzer,
 V01.kunde_id,
 V01.sap_user_kontrolle,
 V01.mandant_id_kunde,
 V01.dat_lief_soll,
 V03.wrg_id,
 V03.wrg_typ_id,
 vk_netto_waqfk_soll,
 vk_netto_waqfk_ist,
 vk_netto_waqfk_fehler_abs,
 vk_netto_waqfk_fehler_sal;