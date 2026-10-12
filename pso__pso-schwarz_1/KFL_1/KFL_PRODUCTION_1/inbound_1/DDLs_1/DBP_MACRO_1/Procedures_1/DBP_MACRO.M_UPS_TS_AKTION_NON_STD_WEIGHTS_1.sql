CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPS_TS_AKTION_NON_STD_WEIGHTS(
    P_MANDANT_ID NUMBER, 
    P_WERBETYP_ID NUMBER, 
    P_KJWO NUMBER,
    P_DAT_QUELLE VARCHAR(16777216), 
    P_DAT_ZIEL VARCHAR(16777216), 
    P_WEIGHT FLOAT, 
    P_TS_LOESCHEN_FG NUMBER
)
-- 2023-10-31, dknop, INC7512744, adding ZEROIFNULL in Delete section, it was impossible to delete records when gewichtung_prz was NULL
RETURNS STRING
LANGUAGE SQL
EXECUTE AS OWNER
AS 
$$
BEGIN 

CASE WHEN COALESCE(:P_TS_LOESCHEN_FG,0) != 1 THEN 
MERGE INTO DBP_MSI_DATA.ts_wbs_aktion_non_std_weights_1 AS target
USING (
        SELECT
            wt.mandant_id
            ,wt.WERBE_TYP_ID 
            ,w.kjwo
            ,abw.dat_quelle
            ,abw.dat_ziel
            ,dv.dat AS dat_von_orig
            ,db.dat AS dat_bis_orig
            ,abw.gewichtung_prz
            -- ,abw.ts_loeschen_fg
            FROM dbp_view.v_woche_1 w --kjwo = führend
            JOIN dbp_view.v_woche_1 fw --folgewoche (wichtig beim jahreswechsel)
            ON w.wo_dat_bis+1 = fw.wo_dat_von
            CROSS JOIN --Standardwerbetype pro Land_1 
                (SELECT DISTINCT MANDANT_ID, WERBE_TYP_ID, WTAG_ID_START, WTAG_ID_ENDE 
                 FROM dbp_view.v_l_werbe_typ_1 wt
                 WHERE (MANDANT_ID IN (2,6,7) AND WERBE_TYP_ID = 6)
                 OR (MANDANT_ID = 1 AND WERBE_TYP_ID = 2)
                 OR (MANDANT_ID IN (3,4,5) AND WERBE_TYP_ID = 5)
                 OR (MANDANT_ID = 8 AND WERBE_TYP_ID = 7)
                 ) wt

            JOIN dbp_view.v_tag_1 dv
            ON dv.kjwo=w.kjwo
            AND dv.wtag_id=wt.wtag_id_start --startdatum in der kw

            JOIN dbp_view.v_tag_1 db
            ON (CASE WHEN wt.wtag_id_start > wtag_id_ende THEN fw.kjwo ELSE  w.kjwo END ) = db.kjwo
            AND db.wtag_id=wt.wtag_id_ende --enddatum ggfs. mit wochenuebergang

            JOIN (SELECT :P_MANDANT_ID AS mandant_id
                    , :P_WERBETYP_ID AS werbe_typ_id
                    , :P_KJWO AS kjwo
                    , :P_DAT_QUELLE AS dat_quelle
                    , :P_DAT_ZIEL AS dat_ziel
                    , :P_WEIGHT AS gewichtung_prz
                    -- , :P_TS_LOESCHEN_FG AS ts_loeschen_fg
                     ) abw
            ON wt.mandant_id=abw.mandant_id
            AND wt.werbe_typ_id=abw.werbe_typ_id
            AND w.kjwo=abw.kjwo
	) AS source
	ON target.mandant_id = SOURCE.mandant_id
		AND target.werbe_typ_id = SOURCE.werbe_typ_id
		AND target.kjwo = SOURCE.kjwo
		AND target.dat_quelle = SOURCE.dat_quelle
		AND target.dat_ziel = SOURCE.dat_ziel
		-- AND (SOURCE.ts_loeschen_fg = 0 OR SOURCE.ts_loeschen_fg is NULL)
	WHEN MATCHED THEN
		UPDATE SET target.gewichtung_prz = SOURCE.gewichtung_prz
	WHEN NOT MATCHED THEN
		INSERT (mandant_id, werbe_typ_id, kjwo, dat_quelle, dat_ziel, gewichtung_prz,  dat_von_orig,dat_bis_orig)
		VALUES (
			source.mandant_id
			, source.werbe_typ_id
			, source.kjwo
			, source.dat_quelle
			, source.dat_ziel
			, source.gewichtung_prz
            -- , 0
            , source.dat_von_orig
            , source.dat_bis_orig
        );
ELSE 

DELETE FROM DBP_MSI_DATA.ts_wbs_aktion_non_std_weights_1
				WHERE  mandant_id = :P_MANDANT_ID
					AND werbe_typ_id = :P_WERBETYP_ID
					AND kjwo = :P_KJWO
					AND dat_quelle = :P_DAT_QUELLE
					AND dat_ziel = :P_DAT_ZIEL
                    AND ZEROIFNULL(gewichtung_prz) = ZEROIFNULL(:P_WEIGHT);
					-- AND :P_TS_LOESCHEN_FG = 1;   
END; 

COMMIT; 
RETURN 'Weights Tabelle wurde aktualisiert';

END;

$$;