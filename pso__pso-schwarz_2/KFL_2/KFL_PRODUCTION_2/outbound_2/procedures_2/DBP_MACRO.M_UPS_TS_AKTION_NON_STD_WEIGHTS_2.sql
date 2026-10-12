-- 2023-10-31, dknop, INC7512744, adding ZEROIFNULL in Delete section, it was impossible to delete records when gewichtung_prz was NULL



CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_aktion_non_std_weights(IN P_MANDANT_ID INT64, IN P_WERBETYP_ID INT64, IN P_KJWO INT64, IN P_DAT_QUELLE STRING, IN P_DAT_ZIEL STRING, IN P_WEIGHT FLOAT64, IN P_TS_LOESCHEN_FG INT64, OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
IF COALESCE(P_TS_LOESCHEN_FG, 0) <> 1 THEN
    BEGIN
    MERGE INTO dbp_msi_data.ts_wbs_aktion_non_std_weights_2 AS TARGET
USING (SELECT wt.mandant_id, wt.werbe_typ_id, W.kjwo, abw.dat_quelle, abw.dat_ziel, DV.dat AS dat_von_orig, DB.dat AS dat_bis_orig, abw.gewichtung_prz
    FROM dbp_view.v_woche_2 AS W
        INNER JOIN dbp_view.v_woche_2 AS FW ON DATE_ADD(W.wo_dat_bis, INTERVAL 1 DAY) = FW.wo_dat_von
        INNER JOIN (SELECT DISTINCT *
            FROM dbp_view.v_l_werbe_typ_2 AS WT
            WHERE mandant_id IN (2, 6, 7) AND werbe_typ_id = 6 OR mandant_id = 1 AND werbe_typ_id = 2 OR mandant_id IN (3, 4, 5) AND werbe_typ_id = 5 OR mandant_id = 8 AND werbe_typ_id = 7) AS wt ON TRUE
        INNER JOIN dbp_view.v_tag_2 AS DV ON W.kjwo = DV.kjwo AND wt.wtag_id_start = DV.wtag_id
        INNER JOIN dbp_view.v_tag_2 AS DB ON CASE WHEN wt.wtag_id_start > wt.wtag_id_ende THEN FW.kjwo ELSE W.kjwo END = DB.kjwo AND wt.wtag_id_ende = DB.wtag_id
        INNER JOIN (SELECT P_MANDANT_ID AS mandant_id, P_WERBETYP_ID AS werbe_typ_id, P_KJWO AS kjwo, P_DAT_QUELLE AS dat_quelle, P_DAT_ZIEL AS dat_ziel, P_WEIGHT AS gewichtung_prz) AS abw ON wt.mandant_id = abw.mandant_id AND wt.werbe_typ_id = abw.werbe_typ_id AND W.kjwo = abw.kjwo) AS source
ON TARGET.mandant_id = source.mandant_id AND TARGET.werbe_typ_id = source.werbe_typ_id AND TARGET.kjwo = source.kjwo AND TARGET.dat_quelle = CAST(source.dat_quelle AS DATE) AND TARGET.dat_ziel = CAST(source.dat_ziel AS DATE)
WHEN MATCHED THEN UPDATE SET
    gewichtung_prz = CAST(ROUND(ROUND(CAST(source.gewichtung_prz AS BIGNUMERIC), 0), 0) AS NUMERIC)
WHEN NOT MATCHED THEN INSERT (mandant_id, werbe_typ_id, kjwo, dat_quelle, dat_ziel, gewichtung_prz, dat_von_orig, dat_bis_orig) VALUES(CAST(source.mandant_id AS INTEGER), CAST(source.werbe_typ_id AS INTEGER), CAST(source.kjwo AS INTEGER), CAST(source.dat_quelle AS DATE), CAST(source.dat_ziel AS DATE), CAST(ROUND(ROUND(CAST(source.gewichtung_prz AS BIGNUMERIC), 0), 0) AS NUMERIC), source.dat_von_orig, source.dat_bis_orig);
    END;
ELSE
    BEGIN
    DELETE FROM dbp_msi_data.ts_wbs_aktion_non_std_weights_2
WHERE mandant_id = P_MANDANT_ID AND werbe_typ_id = P_WERBETYP_ID AND kjwo = P_KJWO AND dat_quelle = CAST(P_DAT_QUELLE AS DATE) AND dat_ziel = CAST(P_DAT_ZIEL AS DATE) AND IFNULL(gewichtung_prz, 0) = IFNULL(P_WEIGHT, 0);
    -- AND :P_TS_LOESCHEN_FG = 1;   
    END;
END IF;

COMMIT TRANSACTION;
SET out_param  =  'Weights Tabelle wurde aktualisiert';
SELECT out_param;
RETURN;
END;