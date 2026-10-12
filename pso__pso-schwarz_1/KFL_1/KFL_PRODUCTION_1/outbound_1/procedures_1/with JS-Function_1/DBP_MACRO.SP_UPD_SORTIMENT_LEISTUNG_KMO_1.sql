CREATE OR REPLACE PROCEDURE `dbp_macro.sp_upd_sortiment_leistung_kmo`(
  in_mandant_id FLOAT64,
  in_matching_id FLOAT64,
  in_art_id FLOAT64,
  in_gtin STRING,
  in_stk_re_pflege STRING,
  in_vorschlag STRING,
  in_produktwissen_pflege STRING,
  in_lieferantenwissen_pflege STRING,
  in_listung_sst_pflege STRING,
  in_listung_k_sst_pflege STRING,
  in_kjmo FLOAT64,
  in_n_k_artikel FLOAT64,
  in_nl_art_bez STRING,
  in_kjwo_update FLOAT64
)
BEGIN
  
  DECLARE var_stk_re_pflege STRING;
  DECLARE var_vorschlag_hr STRING;
  DECLARE var_listung_sst_pflege STRING;
  DECLARE var_listung_k_sst_pflege STRING;
  DECLARE var_nl_art_bez STRING;
  DECLARE var_special_nl INT64;
  DECLARE sql_stmt STRING;

  
  SET var_stk_re_pflege = NULLIF(in_stk_re_pflege, '');
  SET var_vorschlag_hr = in_vorschlag;
  SET var_listung_sst_pflege = in_listung_sst_pflege;
  SET var_listung_k_sst_pflege = in_listung_k_sst_pflege;
  SET var_nl_art_bez = in_nl_art_bez;

  
  IF in_listung_sst_pflege IS NOT NULL AND in_listung_sst_pflege != '' THEN
    SET var_special_nl = SAFE_CAST(in_listung_sst_pflege AS INT64);
  ELSEIF in_listung_k_sst_pflege IS NOT NULL AND in_listung_k_sst_pflege != '' THEN
    SET var_special_nl = COALESCE(SAFE_CAST(SUBSTR(in_listung_k_sst_pflege, 2, 1) AS INT64), 4);
  ELSE
    SET var_special_nl = 4;
  END IF;

  
  IF (var_listung_sst_pflege IS NULL OR var_listung_sst_pflege = '') AND 
     (var_listung_k_sst_pflege IS NULL OR var_listung_k_sst_pflege = '') AND 
     (in_produktwissen_pflege IS NULL OR in_produktwissen_pflege = '') AND 
     (in_lieferantenwissen_pflege IS NULL OR in_lieferantenwissen_pflege = '') AND 
     (in_vorschlag IS NULL OR in_vorschlag = '') THEN
    
    SET var_nl_art_bez = in_nl_art_bez;
    
  ELSE
    IF in_gtin IS NULL OR in_gtin NOT IN ('-9999', '-9998') THEN
      
      IF in_vorschlag = 'Zurücksetzen' THEN
        SET sql_stmt = """
          UPDATE `dbp_data.sortiment_leistung_1` 
          SET stk_re_pflege = NULL, produktwissen_pflege = NULL, lieferantenwissen_pflege = NULL,
              listung_sst_pflege = NULL, listung_k_sst_pflege = NULL, umsatz_hr = NULL,
              absatz_hr = NULL, rohertrag_hr = NULL, listungsaktion = NULL
          WHERE matching_id = ? AND kjmo = ? AND mandant_id = ? AND kjwo_update = CAST(? AS INT64)
        """;
        EXECUTE IMMEDIATE sql_stmt USING in_matching_id, in_kjmo, in_mandant_id, in_kjwo_update;

        SET sql_stmt = """
          DELETE FROM `dbp_msi_data.erwartete_entwicklung_1`
          WHERE matching_id = ? AND kjmo = ? AND mandant_id = ?
        """;
        EXECUTE IMMEDIATE sql_stmt USING in_matching_id, in_kjmo, in_mandant_id;

      ELSEIF in_vorschlag = 'Keine Veränderung setzen' THEN
        SET sql_stmt = """
          UPDATE `dbp_data.sortiment_leistung_1` 
          SET listung_sst_pflege = NULL, listung_k_sst_pflege = NULL, umsatz_hr = NULL,
              absatz_hr = NULL, rohertrag_hr = NULL, listungsaktion = 'Keine Veränderung'
          WHERE matching_id = ? AND kjmo = ? AND mandant_id = ? AND kjwo_update = CAST(? AS INT64) 
            AND (listungsaktion IS NULL OR listungsaktion = '')
        """;
        EXECUTE IMMEDIATE sql_stmt USING in_matching_id, in_kjmo, in_mandant_id, in_kjwo_update;

      ELSEIF in_vorschlag = 'Keine Veränderung' THEN
        SET sql_stmt = """
          UPDATE `dbp_data.sortiment_leistung_1` 
          SET listung_sst_pflege = NULL, listung_k_sst_pflege = NULL, umsatz_hr = NULL,
              absatz_hr = NULL, rohertrag_hr = NULL, listungsaktion = 'Keine Veränderung'
          WHERE matching_id = ? AND kjmo = ? AND mandant_id = ? AND kjwo_update = CAST(? AS INT64)
        """;
        EXECUTE IMMEDIATE sql_stmt USING in_matching_id, in_kjmo, in_mandant_id, in_kjwo_update;

      ELSEIF in_vorschlag = 'Keine Veränderung zurücksetzen' THEN
        SET sql_stmt = """
          UPDATE `dbp_data.sortiment_leistung_1` 
          SET listungsaktion = NULL
          WHERE matching_id = ? AND kjmo = ? AND mandant_id = ? AND kjwo_update = CAST(? AS INT64) AND listungsaktion = 'Keine Veränderung'
        """;
        EXECUTE IMMEDIATE sql_stmt USING in_matching_id, in_kjmo, in_mandant_id, in_kjwo_update;

      ELSEIF in_vorschlag = 'Produktwissen_1' THEN
        SET sql_stmt = """
          UPDATE `dbp_data.sortiment_leistung_1` 
          SET produktwissen_pflege = produktwissen_vp
          WHERE matching_id = ? AND kjmo = ? AND mandant_id = ? AND kjwo_update = CAST(? AS INT64) 
            AND (produktwissen_pflege IS NULL OR produktwissen_pflege = '') 
            AND (produktwissen_vp IS NOT NULL AND produktwissen_vp <> '')
        """;
        EXECUTE IMMEDIATE sql_stmt USING in_matching_id, in_kjmo, in_mandant_id, in_kjwo_update;

      ELSE
        
        IF in_vorschlag IN ('Wiedereinlistung', 'Neulistung KL-Artikel_1', 'Einlistung') THEN
          SET var_vorschlag_hr = 'Listung erweitern';
        END IF;
        IF var_vorschlag_hr LIKE '%Einlistung Potenzial%' THEN
          SET var_vorschlag_hr = 'Einlistung Potenzialartikel';
        END IF;
        IF (var_listung_sst_pflege = '' OR var_listung_sst_pflege IS NULL) AND (var_listung_k_sst_pflege = '' OR var_listung_k_sst_pflege IS NULL) THEN
          SET var_vorschlag_hr = 'Auslistung';
        END IF;

        SET sql_stmt = """
          UPDATE `dbp_data.sortiment_leistung_1` 
          SET stk_re_pflege = ?, produktwissen_pflege = ?, lieferantenwissen_pflege = ?,
              listung_sst_pflege = TRIM(?), listung_k_sst_pflege = TRIM(?), listungsaktion = ?
          WHERE matching_id = ? AND kjmo = ? AND mandant_id = ? AND kjwo_update = CAST(? AS INT64)
        """;
        EXECUTE IMMEDIATE sql_stmt USING var_stk_re_pflege, in_produktwissen_pflege, in_lieferantenwissen_pflege, var_listung_sst_pflege, var_listung_k_sst_pflege, in_vorschlag, in_matching_id, in_kjmo, in_mandant_id, in_kjwo_update;

        IF (var_listung_sst_pflege != '' AND var_listung_sst_pflege IS NOT NULL) OR 
           (var_listung_k_sst_pflege != '' AND var_listung_k_sst_pflege IS NOT NULL) OR 
           var_vorschlag_hr LIKE '%Auslistung%' THEN
           
           IF var_vorschlag_hr LIKE '%Auslistung%' THEN
             SET var_listung_sst_pflege = '0';
             SET var_listung_k_sst_pflege = 'K0';
           END IF;
           
           IF (var_listung_sst_pflege = '' OR var_listung_sst_pflege IS NULL) AND 
              (var_listung_k_sst_pflege = '' OR var_listung_k_sst_pflege IS NULL) THEN
             SET var_vorschlag_hr = 'Auslistung';
             SET var_listung_sst_pflege = '0';
             SET var_listung_k_sst_pflege = 'K0';
           END IF;
           
           IF var_listung_sst_pflege = '' OR var_listung_sst_pflege IS NULL THEN
             SET var_listung_sst_pflege = '-1';
           END IF;
           IF var_listung_k_sst_pflege = '' OR var_listung_k_sst_pflege IS NULL THEN
             SET var_listung_k_sst_pflege = 'KK';
           END IF;

           SET sql_stmt = """
             INSERT INTO `dbp_msi_data.sortiment_art_kmo_1` (mandant_id, art_id, gtin_id, status_1, kjwo_update) 
             SELECT a.mandant_id, a.art_id, MAX(CAST(CAST(a.gtin_id AS INT64) AS STRING)) AS gtin_id, MAX(a.status_1) AS status_1, CAST(? AS INT64) AS kjwo_update
             FROM `dbp_etl.art_matching_nielsen_per_kmo_1` a
             WHERE a.art_matching_id = ? AND a.mandant_id = ? AND 
                   CASE WHEN a.status_1 <> 'N' AND a.list_kz = 'A' THEN 1 WHEN a.status_1 = 'N' THEN 1 ELSE 0 END = 1
             GROUP BY 1, 2
           """;
           EXECUTE IMMEDIATE sql_stmt USING in_kjwo_update, in_matching_id, in_mandant_id;

           
           SET sql_stmt = """
             UPDATE `dbp_data.sortiment_leistung_1` AS sl
             SET umsatz_hr = x2.umsatz, absatz_hr = x2.absatz, rohertrag_hr = cast(x2.rohertrag as numeric),
                 listungsaktion = CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE x2.vorschlag END 
             FROM (
               SELECT
                 CASE WHEN CASE WHEN MAX(x.vorschlag_) <> 'dynamic' THEN MAX(x.vorschlag_)
                                WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
                                WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
                                ELSE 'SOLL-Listung = IST-Listung' END = 'SOLL-Listung = IST-Listung' 
                      THEN 0 ELSE COALESCE(SUM(x.umsatz_)/CASE WHEN MAX(x.status_1) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) END AS umsatz,
                 CASE WHEN CASE WHEN MAX(x.vorschlag_) <> 'dynamic' THEN MAX(x.vorschlag_)
                                WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
                                WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
                                ELSE 'SOLL-Listung = IST-Listung' END = 'SOLL-Listung = IST-Listung' 
                      THEN 0 ELSE COALESCE(SUM(x.absatz_)/CASE WHEN MAX(x.status_1) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) END AS absatz,
                 CASE WHEN CASE WHEN MAX(x.vorschlag_) <> 'dynamic' THEN MAX(x.vorschlag_)
                                WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
                                WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
                                WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung'
                                ELSE 'SOLL-Listung = IST-Listung' END = 'SOLL-Listung = IST-Listung' 
                      THEN 0 ELSE COALESCE(SUM(x.rohertrag_)/CASE WHEN MAX(x.status_1) = 'G' THEN 1 ELSE COUNT(DISTINCT x.art_id) END,0) END AS rohertrag,
                 SUM(x.anzahl_reduktion) AS anzahl_reduktion_, SUM(x.anzahl_erweiterung) AS anzahl_erweiterung_, MAX(x.vorschlag_) AS vorschlag__,
                 CASE WHEN MAX(x.vorschlag_) <> 'dynamic' THEN MAX(x.vorschlag_)
                      WHEN SUM(x.anzahl_reduktion) = 0 AND SUM(x.anzahl_erweiterung) > 0 THEN 'Listung erweitern'
                      WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) = 0 THEN 'Listung reduzieren'
                      WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) > SUM(x.anzahl_erweiterung) THEN 'Listung reduzieren und erweitern'
                      WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) < SUM(x.anzahl_erweiterung) THEN 'Listung erweitern und reduzieren'
                      WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) >= 0 THEN 'Listung erweitern und reduzieren'
                      WHEN SUM(x.anzahl_reduktion) > 0 AND SUM(x.anzahl_erweiterung) > 0 AND SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) AND SUM(x.umsatz_) <= 0 THEN 'Listung reduzieren und erweitern'
                      WHEN SUM(x.anzahl_reduktion) = SUM(x.anzahl_erweiterung) THEN 'SOLL-Listung = IST-Listung' ELSE 'SOLL-Listung = IST-Listung' END AS vorschlag
               FROM (
                 SELECT a.mandant_id, a.art_id, MAX(b.status_1) AS status_1, MIN(a.list_kz) AS list_kz_, SUM(a.umsatz_hr) AS umsatz_, SUM(a.absatz_hr) AS absatz_, SUM(a.rohertrag_hr) AS rohertrag_, CAST(TRUNC(0) AS INT64) AS anzahl_reduktion, SUM(erweiterung_fg) AS anzahl_erweiterung, CASE WHEN ? = 'Auslistung' THEN 'Auslistung' WHEN MIN(a.list_kz) IN ('B','C1','C2','D1','D2') THEN 'Einlistung Kauflandartikel' ELSE 'dynamic' END AS vorschlag_
                 FROM `dbp_msi_data.kl_listung_kmo_1` a JOIN `dbp_msi_data.sortiment_art_kmo_1` b ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                 WHERE (a.mandant_id, a.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) AND a.listung_art = 'Listung erweitern' AND a.kjwo_update = CAST(? AS INT64) AND a.mandant_id = ? AND a.sm_id_selected = SAFE_CAST(? AS INT64) AND a.ksm_id IS NULL GROUP BY 1,2
                 UNION ALL
                 SELECT a.mandant_id, a.art_id, MAX(b.status_1) AS status_1, MIN(a.list_kz) AS list_kz_, SUM(a.umsatz_hr) AS umsatz_, SUM(a.absatz_hr) AS absatz_, SUM(a.rohertrag_hr) AS rohertrag_, SUM(reduktion_fg) AS anzahl_reduktion, CAST(TRUNC(0) AS INT64) AS anzahl_erweiterung, CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
                 FROM `dbp_msi_data.kl_listung_kmo_1` a JOIN `dbp_msi_data.sortiment_art_kmo_1` b ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                 WHERE (a.mandant_id, a.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) AND a.listung_art = 'Listung reduzieren' AND a.kjwo_update = CAST(? AS INT64) AND a.mandant_id = ? AND a.sm_id_selected = SAFE_CAST(? AS INT64) AND a.sm_id < SAFE_CAST(? AS INT64) AND a.ksm_id IS NULL GROUP BY 1,2
                 UNION ALL
                 SELECT a.mandant_id, a.art_id, MAX(b.status_1) AS status_1, MIN(a.list_kz) AS list_kz_, SUM(a.umsatz_hr) AS umsatz_, SUM(a.absatz_hr) AS absatz_, SUM(a.rohertrag_hr) AS rohertrag_, CAST(TRUNC(0) AS INT64) AS anzahl_reduktion, SUM(erweiterung_fg) AS anzahl_erweiterung, CASE WHEN ? = 'Auslistung' THEN 'Auslistung' WHEN MIN(a.list_kz) IN ('B','C1','C2','D1','D2') THEN 'Einlistung Kauflandartikel' ELSE 'dynamic' END AS vorschlag_
                 FROM `dbp_msi_data.kl_listung_kmo_1` a JOIN `dbp_msi_data.sortiment_art_kmo_1` b ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                 WHERE (a.mandant_id, a.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) AND a.listung_art = 'Listung erweitern' AND a.kjwo_update = CAST(? AS INT64) AND a.mandant_id = ? AND TRIM(a.ksm_id_selected) = TRIM(?) AND a.sm_id IS NULL GROUP BY 1,2
                 UNION ALL
                 SELECT a.mandant_id, a.art_id, MAX(b.status_1) AS status_1, MIN(a.list_kz) AS list_kz_, SUM(a.umsatz_hr) AS umsatz_, SUM(a.absatz_hr) AS absatz_, SUM(a.rohertrag_hr) AS rohertrag_, SUM(reduktion_fg) AS anzahl_reduktion, CAST(TRUNC(0) AS INT64) AS anzahl_erweiterung, CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
                 FROM `dbp_msi_data.kl_listung_kmo_1` a JOIN `dbp_msi_data.sortiment_art_kmo_1` b ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                 WHERE (a.mandant_id, a.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) AND a.listung_art = 'Listung reduzieren' AND a.kjwo_update = CAST(? AS INT64) AND a.mandant_id = ? AND TRIM(a.ksm_id_selected) = TRIM(?) AND SAFE_CAST(SUBSTR(TRIM(a.ksm_id),2,1) AS INT64) < SAFE_CAST(SUBSTR(TRIM(?),2,1) AS INT64) AND a.sm_id IS NULL GROUP BY 1,2
                 UNION ALL
                 SELECT a.mandant_id, a.art_id, MAX(b.status_1) AS status_1, MIN(a.list_kz) AS list_kz_, SUM(a.umsatz_hr) AS umsatz_, SUM(a.absatz_hr) AS absatz_, SUM(a.rohertrag_hr) AS rohertrag_, SUM(reduktion_fg) AS anzahl_reduktion, CAST(TRUNC(0) AS INT64) AS anzahl_erweiterung, CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
                 FROM `dbp_msi_data.kl_listung_kmo_1` a JOIN `dbp_msi_data.sortiment_art_kmo_1` b ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                 WHERE (a.mandant_id, a.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) AND a.listung_art = 'Auslistung' AND a.kjwo_update = CAST(? AS INT64) AND a.mandant_id = ? AND a.sm_id_selected = SAFE_CAST(? AS INT64) AND a.ksm_id IS NULL GROUP BY 1,2
                 UNION ALL
                 SELECT a.mandant_id, a.art_id, MAX(b.status_1) AS status_1, MIN(a.list_kz) AS list_kz_, SUM(a.umsatz_hr) AS umsatz_, SUM(a.absatz_hr) AS absatz_, SUM(a.rohertrag_hr) AS rohertrag_, SUM(reduktion_fg) AS anzahl_reduktion, CAST(TRUNC(0) AS INT64) AS anzahl_erweiterung, CASE WHEN ? = 'Auslistung' THEN 'Auslistung' ELSE 'dynamic' END AS vorschlag_
                 FROM `dbp_msi_data.kl_listung_kmo_1` a JOIN `dbp_msi_data.sortiment_art_kmo_1` b ON a.mandant_id = b.mandant_id AND a.art_id = b.art_id AND a.kjwo_update = b.kjwo_update
                 WHERE (a.mandant_id, a.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) AND a.listung_art = 'Auslistung' AND a.kjwo_update = CAST(? AS INT64) AND a.mandant_id = ? AND TRIM(a.ksm_id_selected) = TRIM(?) AND a.sm_id IS NULL GROUP BY 1,2
                 UNION ALL
                 SELECT a.mandant_id, 1 AS art_id, 'N' AS status_1, 'A' AS list_kz, SUM(a.umsatz_hr) AS umsatz_, SUM(a.absatz_hr) AS absatz_, SUM(a.absatz_hr)*CAST(REPLACE(?,',','.') AS FLOAT64) AS rohertrag_, CAST(TRUNC(0) AS INT64) AS anzahl_reduktion, COUNT(*) AS anzahl_erweiterung, 'Einlistung Potenzialartikel' AS vorschlag_
                 FROM `dbp_msi_data.nl_listung_kmo_1` a WHERE a.gtin NOT IN (SELECT CAST(CAST(gtin_id AS INT64) AS STRING) FROM `dbp_etl.not_listed_basis_kmo_1`) AND a.gtin = ? AND a.listung_art = 'Einlistung Potenzialartikel' AND a.kjwo_update = CAST(? AS INT64) AND a.art_nielsen_bez = ? AND a.sm_id_selected = SAFE_CAST(? AS INT64) AND a.ksm_id IS NULL GROUP BY 1,2
                 UNION ALL
                 SELECT a.mandant_id, 1 AS art_id, 'N' AS status_1, 'A' AS list_kz, SUM(a.umsatz_hr) AS umsatz_, SUM(a.absatz_hr) AS absatz_, SUM(a.absatz_hr)*CAST(REPLACE(?,',','.') AS FLOAT64) AS rohertrag_, CAST(TRUNC(0) AS INT64) AS anzahl_reduktion, COUNT(*) AS anzahl_erweiterung, 'Einlistung Potenzialartikel' AS vorschlag_
                 FROM `dbp_msi_data.nl_listung_kmo_1` a WHERE a.gtin NOT IN (SELECT CAST(CAST(gtin_id AS INT64) AS STRING) FROM `dbp_etl.not_listed_basis_kmo_1`) AND a.gtin = ? AND a.listung_art = 'Einlistung Potenzialartikel' AND a.kjwo_update = CAST(? AS INT64) AND a.art_nielsen_bez = ? AND TRIM(a.ksm_id_selected) = TRIM(?) AND a.sm_id IS NULL GROUP BY 1,2
               ) x 
             ) AS x2
             WHERE (sl.art_id = ? AND sl.kjmo = ? AND sl.mandant_id = ? AND sl.kjwo_update = CAST(? AS INT64)) OR (sl.gtin = ? AND sl.kjmo = ? AND sl.mandant_id = ? AND sl.nielsen_art_bez = ? AND sl.kjwo_update = CAST(? AS INT64))
           """;
           
           EXECUTE IMMEDIATE sql_stmt USING 
             var_vorschlag_hr, 
             var_vorschlag_hr, in_kjwo_update, in_mandant_id, var_listung_sst_pflege, 
             var_vorschlag_hr, in_kjwo_update, in_mandant_id, var_listung_sst_pflege, var_listung_sst_pflege, 
             var_vorschlag_hr, in_kjwo_update, in_mandant_id, var_listung_k_sst_pflege, 
             var_vorschlag_hr, in_kjwo_update, in_mandant_id, var_listung_k_sst_pflege, var_listung_k_sst_pflege, 
             var_vorschlag_hr, in_kjwo_update, in_mandant_id, var_listung_sst_pflege, 
             var_vorschlag_hr, in_kjwo_update, in_mandant_id, var_listung_k_sst_pflege, 
             var_stk_re_pflege, in_gtin, in_kjwo_update, var_nl_art_bez, var_listung_sst_pflege, 
             var_stk_re_pflege, in_gtin, in_kjwo_update, var_nl_art_bez, var_listung_k_sst_pflege, 
             in_art_id, in_kjmo, in_mandant_id, in_kjwo_update, 
             in_gtin, in_kjmo, in_mandant_id, var_nl_art_bez, in_kjwo_update;

           SET sql_stmt = """
             UPDATE `dbp_data.sortiment_leistung_1` AS sl
             SET listungsaktion = z.listungsaktion
             FROM (
               SELECT CASE WHEN listungsaktion = 'Auslistung' THEN listungsaktion
                           WHEN (listung_sst_pflege <> 'N/A' OR listung_k_sst_pflege <> 'N/A') AND anz_maerkte_k_sst = 0 AND anz_maerkte_sst = 0 AND anz_maerkte_baustein_sonstige = 0 AND anz_maerkte_listung_einzel = 0 AND anz_maerkte_listung_gesamt = 0 THEN 'Einlistung Kauflandartikel'
                           ELSE listungsaktion END AS listungsaktion,
                      mandant_id, kjmo, kjwo_update, matching_id
               FROM `dbp_data.sortiment_leistung_1`
               WHERE mandant_id = ? AND art_id IS NOT NULL AND kjmo = ? AND kjwo_update = CAST(? AS INT64) AND matching_id = ?
             ) AS z
             WHERE sl.mandant_id = z.mandant_id AND sl.kjmo = z.kjmo AND sl.kjwo_update = z.kjwo_update AND sl.matching_id = z.matching_id
               AND sl.mandant_id = ? AND sl.kjmo = ? AND sl.kjwo_update = CAST(? AS INT64) AND sl.matching_id = ?
           """;
           EXECUTE IMMEDIATE sql_stmt USING in_mandant_id, in_kjmo, in_kjwo_update, in_matching_id, in_mandant_id, in_kjmo, in_kjwo_update, in_matching_id;

           IF var_vorschlag_hr NOT IN ('Keine Veränderung', 'Keine Veränderung setzen', 'Keine Veränderung zurücksetzen', 'Produktwissen_1', 'Zurücksetzen') AND var_vorschlag_hr IS NOT NULL THEN
             SET sql_stmt = """
               DELETE FROM `dbp_msi_data.erwartete_entwicklung_1`
               WHERE matching_id = ? AND kjmo = ? AND mandant_id = ?
             """;
             EXECUTE IMMEDIATE sql_stmt USING in_matching_id, in_kjmo, in_mandant_id;

             SET sql_stmt = """
               INSERT INTO `dbp_msi_data.erwartete_entwicklung_1` (mandant_id, kjmo, matching_id, kjwo_update, wrg_id, kl_wg_id, kl_owg_id, kl_uwg_id, owg_id, wg_id, wug_id, sm_id, ksm_id, umsatz_hr, absatz_hr, rohertrag_hr)
               SELECT CAST(? AS INT64), CAST(? AS INT64) AS kjmo, CAST(? AS INT64), CAST(? AS INT64) AS kjwo_update, z3.default_wrg AS wrg_id, y3.kl_wg_id, y3.kl_owg_id, y3.kl_uwg_id, y3.kl_wg_id AS owg_id, y3.kl_owg_id AS wg_id, y3.kl_uwg_id AS wug_id, x3.sm_id, x3.ksm_id, COALESCE(SUM(x3.umsatz_)/CASE WHEN MAX(x3.status_1) = 'G' THEN 1 ELSE COUNT(DISTINCT x3.art_id) END,0) AS umsatz, COALESCE(SUM(x3.absatz_)/CASE WHEN MAX(x3.status_1) = 'G' THEN 1 ELSE COUNT(DISTINCT x3.art_id) END,0) AS absatz, COALESCE(SUM(x3.rohertrag_)/CASE WHEN MAX(x3.status_1) = 'G' THEN 1 ELSE COUNT(DISTINCT x3.art_id) END,0) AS rohertrag
               FROM (
                 SELECT CAST(? AS INT64) AS mandant_id, CAST(? AS INT64) AS matching_id, a4.sm_id, '  ' AS ksm_id, a4.art_id, MAX(b4.status_1) AS status_1, SUM(a4.umsatz_hr) AS umsatz_, SUM(a4.absatz_hr) AS absatz_, SUM(a4.rohertrag_hr) AS rohertrag_ FROM `dbp_msi_data.kl_listung_kmo_1` a4 JOIN `dbp_msi_data.sortiment_art_kmo_1` b4 ON a4.mandant_id = b4.mandant_id AND a4.art_id = b4.art_id WHERE (a4.mandant_id,a4.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) AND a4.listung_art = 'Listung erweitern' AND a4.kjwo_update = CAST(? AS INT64) AND a4.mandant_id = CAST(? AS INT64) AND a4.sm_id_selected = SAFE_CAST(? AS INT64) AND a4.ksm_id IS NULL GROUP BY 1,2,3,4,5 HAVING umsatz_ <> 0 UNION ALL
                 SELECT CAST(? AS INT64) AS mandant_id, CAST(? AS INT64) AS matching_id, a4.sm_id, '  ' AS ksm_id, a4.art_id, MAX(b4.status_1) AS status_1, SUM(a4.umsatz_hr) AS umsatz_, SUM(a4.absatz_hr) AS absatz_, SUM(a4.rohertrag_hr) AS rohertrag_ FROM `dbp_msi_data.kl_listung_kmo_1` a4 JOIN `dbp_msi_data.sortiment_art_kmo_1` b4 ON a4.mandant_id = b4.mandant_id AND a4.art_id = b4.art_id WHERE (a4.mandant_id,a4.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) AND a4.listung_art = 'Listung reduzieren' AND a4.kjwo_update = CAST(? AS INT64) AND a4.mandant_id = CAST(? AS INT64) AND a4.sm_id_selected = SAFE_CAST(? AS INT64) AND a4.sm_id < SAFE_CAST(? AS INT64) AND a4.ksm_id IS NULL GROUP BY 1,2,3,4,5 HAVING umsatz_ <> 0 UNION ALL
                 SELECT CAST(? AS INT64) AS mandant_id, CAST(? AS INT64) AS matching_id, -1 AS sm_id, TRIM(a4.ksm_id) AS ksm_id, a4.art_id, MAX(b4.status_1) AS status_1, SUM(a4.umsatz_hr) AS umsatz_, SUM(a4.absatz_hr) AS absatz_, SUM(a4.rohertrag_hr) AS rohertrag_ FROM `dbp_msi_data.kl_listung_kmo_1` a4 JOIN `dbp_msi_data.sortiment_art_kmo_1` b4 ON a4.mandant_id = b4.mandant_id AND a4.art_id = b4.art_id WHERE (a4.mandant_id,a4.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) AND a4.listung_art = 'Listung erweitern' AND a4.kjwo_update = CAST(? AS INT64) AND a4.mandant_id = CAST(? AS INT64) AND TRIM(a4.ksm_id_selected) = TRIM(?) AND a4.sm_id IS NULL GROUP BY 1,2,3,4,5 HAVING umsatz_ <> 0 UNION ALL
                 SELECT CAST(? AS INT64) AS mandant_id, CAST(? AS INT64) AS matching_id, -1 AS sm_id, TRIM(a4.ksm_id) AS ksm_id, a4.art_id, MAX(b4.status_1) AS status_1, SUM(a4.umsatz_hr) AS umsatz_, SUM(a4.absatz_hr) AS absatz_, SUM(a4.rohertrag_hr) AS rohertrag_ FROM `dbp_msi_data.kl_listung_kmo_1` a4 JOIN `dbp_msi_data.sortiment_art_kmo_1` b4 ON a4.mandant_id = b4.mandant_id AND a4.art_id = b4.art_id WHERE (a4.mandant_id,a4.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) AND a4.listung_art = 'Listung reduzieren' AND a4.kjwo_update = CAST(? AS INT64) AND a4.mandant_id = CAST(? AS INT64) AND TRIM(a4.ksm_id_selected) = TRIM(?) AND SAFE_CAST(SUBSTR(TRIM(a4.ksm_id),2,1) AS INT64) < SAFE_CAST(SUBSTR(TRIM(?),2,1) AS INT64) AND a4.sm_id IS NULL GROUP BY 1,2,3,4,5 HAVING umsatz_ <> 0 UNION ALL
                 SELECT CAST(? AS INT64) AS mandant_id, CAST(? AS INT64) AS matching_id, -1 AS sm_id, TRIM(a4.ksm_id) AS ksm_id, a4.art_id, MAX(b4.status_1) AS status_1, SUM(a4.umsatz_hr) AS umsatz_, SUM(a4.absatz_hr) AS absatz_, SUM(a4.rohertrag_hr) AS rohertrag_ FROM `dbp_msi_data.kl_listung_kmo_1` a4 JOIN `dbp_msi_data.sortiment_art_kmo_1` b4 ON a4.mandant_id = b4.mandant_id AND a4.art_id = b4.art_id WHERE (a4.mandant_id,a4.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) AND a4.listung_art = 'Auslistung' AND a4.kjwo_update = CAST(? AS INT64) AND a4.mandant_id = CAST(? AS INT64) AND TRIM(a4.ksm_id_selected) = TRIM(?) AND a4.sm_id IS NULL GROUP BY 1,2,3,4,5 HAVING umsatz_ <> 0 UNION ALL
                 SELECT CAST(? AS INT64) AS mandant_id, CAST(? AS INT64) AS matching_id, a4.sm_id, '  ' AS ksm_id, a4.art_id, MAX(b4.status_1) AS status_1, SUM(a4.umsatz_hr) AS umsatz_, SUM(a4.absatz_hr) AS absatz_, SUM(a4.rohertrag_hr) AS rohertrag_ FROM `dbp_msi_data.kl_listung_kmo_1` a4 JOIN `dbp_msi_data.sortiment_art_kmo_1` b4 ON a4.mandant_id = b4.mandant_id AND a4.art_id = b4.art_id WHERE (a4.mandant_id,a4.art_id) NOT IN (SELECT (mandant_id, art_id) FROM `dbp_etl.not_listed_basis_kmo_1`) AND a4.listung_art = 'Auslistung' AND a4.kjwo_update = CAST(? AS INT64) AND a4.mandant_id = CAST(? AS INT64) AND a4.sm_id_selected = SAFE_CAST(? AS INT64) AND a4.ksm_id IS NULL GROUP BY 1,2,3,4,5 HAVING umsatz_ <> 0
               ) x3
               JOIN (SELECT mandant_id, art_matching_id, MAX(kl_wg_id) AS kl_wg_id, MAX(kl_owg_id) AS kl_owg_id, MAX(kl_uwg_id) AS kl_uwg_id FROM `dbp_etl.art_matching_nielsen_per_kmo_1` GROUP BY 1,2) y3 ON x3.matching_id = y3.art_matching_id AND x3.mandant_id = y3.mandant_id
               JOIN `dbp_data.mandant_1` z3 ON CAST(? AS INT64) = z3.mandant_id
               GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13
             """;
             EXECUTE IMMEDIATE sql_stmt USING 
               in_mandant_id, in_kjmo, in_matching_id, in_kjwo_update, 
               in_mandant_id, in_matching_id, in_kjwo_update, in_mandant_id, var_listung_sst_pflege, 
               in_mandant_id, in_matching_id, in_kjwo_update, in_mandant_id, var_listung_sst_pflege, var_listung_sst_pflege, 
               in_mandant_id, in_matching_id, in_kjwo_update, in_mandant_id, var_listung_k_sst_pflege, 
               in_mandant_id, in_matching_id, in_kjwo_update, in_mandant_id, var_listung_k_sst_pflege, var_listung_k_sst_pflege, 
               in_mandant_id, in_matching_id, in_kjwo_update, in_mandant_id, var_listung_k_sst_pflege, 
               in_mandant_id, in_matching_id, in_kjwo_update, in_mandant_id, var_listung_sst_pflege, 
               in_mandant_id;
           END IF;

           SET sql_stmt = """
             DELETE FROM `dbp_msi_data.sortiment_art_kmo_1`
             WHERE (mandant_id, art_id, gtin_id, kjwo_update) IN (
               SELECT DISTINCT(a.mandant_id, a.art_id, CAST(CAST(a.gtin_id AS INT64) AS STRING) , CAST(? AS INT64) )
               FROM `dbp_etl.art_matching_nielsen_per_kmo_1` a
               WHERE a.art_matching_id = ? AND a.mandant_id = ?
               
             )
           """;
           EXECUTE IMMEDIATE sql_stmt USING in_kjwo_update, in_matching_id, in_mandant_id;
        END IF;
      END IF;

      
      IF in_vorschlag = 'Zurücksetzen' THEN
        SET sql_stmt = """
          DELETE FROM `dbp_data.art_kl_preislage_zu_per_neu_1`
          WHERE kjmo = ? AND kjwo_update = CAST(? AS INT64) AND art_matching_id = ? AND mandant_id = ?
        """;
        EXECUTE IMMEDIATE sql_stmt USING in_kjmo, in_kjwo_update, in_matching_id, in_mandant_id;

        SET sql_stmt = """
          INSERT INTO `dbp_data.art_kl_preislage_zu_per_neu_1`
          SELECT * FROM `dbp_data.art_kl_preislage_zu_per_1`
          WHERE kjmo = ? AND kjwo_update = CAST(? AS INT64) AND art_matching_id = ? AND mandant_id = ?
        """;
        EXECUTE IMMEDIATE sql_stmt USING in_kjmo, in_kjwo_update, in_matching_id, in_mandant_id;
      ELSE
        SET sql_stmt = """
          INSERT INTO `dbp_data.art_kl_preislage_zu_per_neu_1` (mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id, sm_id, ksm_id, owg_id, wg_id, wug_id, vk_brutto_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa, menge, menge_af, menge_sa) 
          SELECT a.mandant_id, a.matching_id AS art_matching_id, a.kjmo, a.kjwo_update, x.default_wrg AS wrg_id, TRIM(CAST(b.k AS STRING)) AS sm_id, '' AS ksm_id, a.kl_wg_id AS owg_id, a.kl_owg_id AS wg_id, a.kl_uwg_id AS wug_id, a.vk_preis, a.durchschnittspreis, c.umsatz_brutto, c.umsatz_brutto_af, c.umsatz_brutto_sa, c.menge, c.menge_af, c.menge_sa
          FROM `dbp_data.sortiment_leistung_1` a 
          JOIN `dbp_data.art_kl_preislage_zu_per_neu_1` c ON a.mandant_id = c.mandant_id AND a.kjmo = c.kjmo AND a.matching_id = c.art_matching_id AND a.listung_sst_mvke = c.sm_id 
          JOIN (SELECT wtag_id AS k FROM `dbp_data.tag_1` WHERE wtag_id BETWEEN 1 AND 5 GROUP BY 1) b ON SAFE_CAST(TRIM(a.listung_sst_pflege) AS INT64) <= b.k AND b.k < CASE WHEN a.listung_sst_mvke = 'N/A' THEN 6 ELSE SAFE_CAST(a.listung_sst_mvke AS INT64) END 
          JOIN `dbp_data.mandant_1` x ON a.mandant_id = x.mandant_id
          WHERE a.umsatz_hr IS NOT NULL AND a.mandant_id = ? AND a.kjmo IN (SELECT kjmo FROM `dbp_data.monat_1` WHERE kjmo = ?) AND a.listungsaktion IN ('Listung erweitern','Einlistung Kauflandartikel','Listung reduzieren und erweitern','Listung erweitern und reduzieren') AND (a.mandant_id,a.matching_id,a.kjmo,b.k) NOT IN (SELECT (mandant_id, art_matching_id, kjmo, SAFE_CAST(sm_id AS INT64)) FROM `dbp_data.art_kl_preislage_zu_per_neu_1` WHERE sm_id NOT IN ('N/A','-1') AND mandant_id = ?)
        """;
        EXECUTE IMMEDIATE sql_stmt USING in_mandant_id, in_kjmo, in_mandant_id;

        SET sql_stmt = """
          INSERT INTO `dbp_data.art_kl_preislage_zu_per_neu_1` (mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id, sm_id, ksm_id, owg_id, wg_id, wug_id, vk_brutto_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa, menge, menge_af, menge_sa) 
          SELECT a.mandant_id, a.matching_id AS art_matching_id, a.kjmo, a.kjwo_update, x.default_wrg AS wrg_id, TRIM(CAST(b.k AS STRING)) AS sm_id, '' AS ksm_id, a.kl_wg_id AS owg_id, a.kl_owg_id AS wg_id, a.kl_uwg_id AS wug_id, a.vk_preis, a.durchschnittspreis, c.umsatz_brutto, c.umsatz_brutto_af, c.umsatz_brutto_sa, c.menge, c.menge_af, c.menge_sa
          FROM `dbp_data.sortiment_leistung_1` a 
          JOIN `dbp_data.art_kl_preislage_zu_per_neu_1` c ON a.mandant_id = c.mandant_id AND a.kjmo = c.kjmo AND a.matching_id = c.art_matching_id AND a.listung_k_sst_mvke = c.ksm_id 
          JOIN (SELECT akt_tag AS k FROM `dbp_data.tag_1` WHERE akt_tag BETWEEN 1 AND 9 GROUP BY 1) b ON SAFE_CAST(TRIM(SUBSTR(a.listung_k_sst_pflege,2,1)) AS INT64) <= b.k AND b.k < CASE WHEN a.listung_k_sst_mvke = 'N/A' THEN 10 ELSE SAFE_CAST(SUBSTR(a.listung_k_sst_mvke,2,1) AS INT64) END 
          JOIN `dbp_data.mandant_1` x ON a.mandant_id = x.mandant_id
          WHERE a.umsatz_hr IS NOT NULL AND a.mandant_id = ? AND a.kjmo IN (SELECT kjmo FROM `dbp_data.monat_1` WHERE kjmo = ?) AND a.listungsaktion IN ('Listung erweitern','Einlistung Kauflandartikel','Listung reduzieren und erweitern','Listung erweitern und reduzieren') AND (a.mandant_id,a.matching_id,a.kjmo,b.k) NOT IN (SELECT (mandant_id, art_matching_id, kjmo, SAFE_CAST(SUBSTR(ksm_id,2,1) AS INT64)) FROM `dbp_data.art_kl_preislage_zu_per_neu_1` WHERE ksm_id NOT IN ('') AND mandant_id = ?)
        """;
        EXECUTE IMMEDIATE sql_stmt USING in_mandant_id, in_kjmo, in_mandant_id;

        SET sql_stmt = """
          INSERT INTO `dbp_data.art_kl_preislage_zu_per_neu_1` (mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id, sm_id, ksm_id, owg_id, wg_id, wug_id, vk_brutto_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa, menge, menge_af, menge_sa) 
          SELECT a.mandant_id, a.matching_id AS art_matching_id, a.kjmo, a.kjwo_update, x.default_wrg AS wrg_id, '-1' AS sm_id, CONCAT('K', TRIM(CAST(b.k AS STRING))) AS ksm_id, a.kl_wg_id AS owg_id, a.kl_owg_id AS wg_id, a.kl_uwg_id AS wug_id, a.vk_preis, a.durchschnittspreis, c.umsatz_brutto, c.umsatz_brutto_af, c.umsatz_brutto_sa, c.menge, c.menge_af, c.menge_sa
          FROM `dbp_data.sortiment_leistung_1` a 
          JOIN `dbp_data.art_kl_preislage_zu_per_neu_1` c ON a.mandant_id = c.mandant_id AND a.kjwo_update = c.kjwo_update AND a.matching_id = c.art_matching_id AND a.listung_k_sst_mvke = c.ksm_id 
          JOIN (SELECT akt_tag AS k FROM `dbp_data.tag_1` WHERE akt_tag BETWEEN 1 AND 9 GROUP BY 1) b ON SAFE_CAST(TRIM(SUBSTR(COALESCE(a.listung_k_sst_pflege,'K9'),2,1)) AS INT64) <= b.k AND b.k < SAFE_CAST(SUBSTR(COALESCE(a.listung_k_sst_mvke,'K9'),2,1) AS INT64) 
          JOIN `dbp_data.mandant_1` x ON a.mandant_id = x.mandant_id
          WHERE a.umsatz_hr IS NOT NULL AND a.mandant_id = ? AND a.kjwo_update = CAST(? AS INT64) AND a.listungsaktion IN ('Listung erweitern','Einlistung Kauflandartikel','Listung reduzieren und erweitern','Listung erweitern und reduzieren') AND (a.mandant_id,a.matching_id,a.kjwo_update,b.k) NOT IN (SELECT (mandant_id, art_matching_id, kjwo_update, SAFE_CAST(SUBSTR(ksm_id,2,1) AS INT64)) FROM `dbp_data.art_kl_preislage_zu_per_neu_1` WHERE ksm_id IS NOT NULL AND ksm_id <> '' AND kjwo_update = CAST(? AS INT64) AND mandant_id = ?)
        """;
        EXECUTE IMMEDIATE sql_stmt USING in_mandant_id, in_kjwo_update, in_kjwo_update, in_mandant_id;

        SET sql_stmt = """
          DELETE FROM `dbp_data.art_kl_preislage_zu_per_neu_1`
          WHERE (mandant_id, art_matching_id, kjmo, ksm_id, kjwo_update) IN (
            SELECT (a.mandant_id, a.matching_id, a.kjmo, CONCAT('K', CAST(b.k AS STRING)), a.kjwo_update)
            FROM `dbp_data.sortiment_leistung_1` a 
            JOIN (SELECT akt_tag AS k FROM `dbp_data.tag_1` WHERE akt_tag BETWEEN 1 AND 9 GROUP BY 1) b ON SAFE_CAST(SUBSTR(COALESCE(a.listung_k_sst_pflege,'K9'),2,1) AS INT64) > b.k AND b.k <= SAFE_CAST(SUBSTR(COALESCE(a.listung_k_sst_mvke,'K9'),2,1) AS INT64)
            WHERE a.kjwo_update = CAST(? AS INT64) AND a.umsatz_hr IS NOT NULL AND a.mandant_id = ? AND a.listungsaktion IN ('Listung reduzieren','Listung reduzieren und erweitern','Listung erweitern und reduzieren')
          )
        """;
        EXECUTE IMMEDIATE sql_stmt USING in_kjwo_update, in_mandant_id;

        SET sql_stmt = """
          INSERT INTO `dbp_data.art_kl_preislage_zu_per_neu_1` (mandant_id, art_matching_id, kjmo, kjwo_update, wrg_id, sm_id, ksm_id, owg_id, wg_id, wug_id, vk_brutto_pk_1, durchschnitt_preis_kasse, umsatz_brutto, umsatz_brutto_af, umsatz_brutto_sa, menge, menge_af, menge_sa) 
          SELECT a.mandant_id, a.matching_id AS art_matching_id, a.kjmo, a.kjwo_update, x.default_wrg AS wrg_id, '-1' AS sm_id, CONCAT('K', TRIM(CAST(b.k AS STRING))) AS ksm_id, a.kl_wg_id AS owg_id, a.kl_owg_id AS wg_id, a.kl_uwg_id AS wug_id, a.vk_preis, a.durchschnittspreis, c.umsatz_brutto, c.umsatz_brutto_af, c.umsatz_brutto_sa, c.menge, c.menge_af, c.menge_sa
          FROM `dbp_data.sortiment_leistung_1` a 
          JOIN `dbp_data.art_nielsen_preislage_zu_per_1` c ON a.mandant_id = c.mandant_id AND a.kjmo = c.kjmo AND a.matching_id = c.art_matching_id AND a.kjwo_update = CAST(? AS INT64) 
          JOIN (SELECT akt_tag AS k FROM `dbp_data.tag_1` WHERE akt_tag BETWEEN 1 AND 9 GROUP BY 1) b ON SAFE_CAST(TRIM(SUBSTR(COALESCE(a.listung_k_sst_pflege,'K9'),2,1)) AS INT64) <= b.k 
          JOIN `dbp_data.mandant_1` x ON a.mandant_id = x.mandant_id
          WHERE a.umsatz_hr IS NOT NULL AND a.mandant_id = CAST(? AS INT64) AND a.kjwo_update = CAST(? AS INT64) AND a.listungsaktion = 'Einlistung Potenzialartikel' AND (a.mandant_id,a.matching_id,a.kjwo_update,b.k) NOT IN (SELECT (mandant_id, art_matching_id, kjwo_update, SAFE_CAST(SUBSTR(ksm_id,2,1) AS INT64)) FROM `dbp_data.art_kl_preislage_zu_per_neu_1` WHERE ksm_id IS NOT NULL AND ksm_id <> '' AND kjwo_update = CAST(? AS INT64) AND mandant_id = ?)
        """;
        EXECUTE IMMEDIATE sql_stmt USING in_kjwo_update, in_mandant_id, in_kjwo_update, in_kjwo_update, in_mandant_id;

        SET sql_stmt = """
          DELETE FROM `dbp_data.art_kl_preislage_zu_per_neu_1`
          WHERE (mandant_id, art_matching_id, kjwo_update) IN (
            SELECT (a.mandant_id, a.matching_id, a.kjwo_update) 
            FROM `dbp_data.sortiment_leistung_1` a 
            WHERE a.kjwo_update = CAST(? AS INT64) AND a.mandant_id = CAST(? AS INT64) AND a.umsatz_hr IS NOT NULL AND a.listungsaktion = 'Auslistung'
          )
        """;
        EXECUTE IMMEDIATE sql_stmt USING in_kjwo_update, in_mandant_id;
      END IF;
    END IF;
  END IF;

END;