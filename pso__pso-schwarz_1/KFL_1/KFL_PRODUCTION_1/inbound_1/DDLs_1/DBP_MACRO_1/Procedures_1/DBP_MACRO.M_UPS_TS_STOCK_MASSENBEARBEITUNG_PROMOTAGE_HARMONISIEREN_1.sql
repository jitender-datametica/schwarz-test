CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPS_TS_STOCK_MASSENBEARBEITUNG_PROMOTAGE_HARMONISIEREN(
    P_ART_IDS         VARCHAR,
    P_WUP_IDS         VARCHAR,
    P_NB_IDS          VARCHAR,
    P_MANDANT_IDS     VARCHAR,
    P_DAT_VON_LIST    VARCHAR,
    P_DAT_BIS_LIST    VARCHAR,
    P_ORDER_PROPOSAL  VARCHAR,
    P_CONFIRM_FG      FLOAT
)
RETURNS VARCHAR(16777216)
LANGUAGE SQL
COMMENT='Massenbearbeitung auf Artikelebene WBS – Bestandsanpassung an Promotion-Tage (Mehrfach-ART_1/WUP_1/DAT_VON/DAT_BIS mit aggregiertem ORDER_PROPOSAL aus positionsbasiertem Input)'
EXECUTE AS OWNER
AS
$$
DECLARE
    dummy_1 FLOAT;
BEGIN

    IF (:P_CONFIRM_FG = 1) THEN

        ------------------------------------------------------------------
        -- Helper mapping: from flat positional lists to unique combination
        -- (ART_ID, WUP_ID, DAT_VON, DAT_BIS) -> ORDER_PROPOSAL
        ------------------------------------------------------------------
        -- We will use this in both UPDATE and MERGE
        -- Logic: take MAX(order_proposal_raw) per combination.
        ------------------------------------------------------------------

        ------------------------------------------------------------------
        -- STEP 1: UPDATE existing rows
        ------------------------------------------------------------------
        UPDATE DBP_MSI_DATA.TS_WBS_BESTELLVORSCHLAG_IN_PROMO_1 t
        SET MENGE_BESTELLVORSCHLAG_IN_PROMO_AME = COALESCE(m.ORDER_PROPOSAL, t.MENGE_BESTELLVORSCHLAG_IN_PROMO_AME),
            TD_UPDATE      = CURRENT_TIMESTAMP
        FROM (
            WITH
            ART_LIST AS (
                SELECT ROW_NUMBER() OVER (ORDER BY SEQ4()) AS rn,
                       TRIM(value)::NUMBER AS ART_ID
                FROM TABLE(split_to_table(:P_ART_IDS, ','))
            ),
            WUP_LIST AS (
                SELECT ROW_NUMBER() OVER (ORDER BY SEQ4()) AS rn,
                       TRIM(value)::NUMBER AS WUP_ID
                FROM TABLE(split_to_table(:P_WUP_IDS, ','))
            ),
            DAT_VON_LIST AS (
                SELECT ROW_NUMBER() OVER (ORDER BY SEQ4()) AS rn,
                       TRIM(value)::DATE AS DAT_VON
                FROM TABLE(split_to_table(:P_DAT_VON_LIST, ','))
            ),
            DAT_BIS_LIST AS (
                SELECT ROW_NUMBER() OVER (ORDER BY SEQ4()) AS rn,
                       TRIM(value)::DATE AS DAT_BIS
                FROM TABLE(split_to_table(:P_DAT_BIS_LIST, ','))
            ),
            ORD_LIST AS (
                SELECT ROW_NUMBER() OVER (ORDER BY SEQ4()) AS rn,
                       TRIM(COALESCE(value, 0))::FLOAT AS ORDER_PROPOSAL_RAW
                FROM TABLE(split_to_table(:P_ORDER_PROPOSAL, ','))
            ),
            POS_MAP AS (
                SELECT
                    a.ART_ID,
                    w.WUP_ID,
                    v.DAT_VON,
                    b.DAT_BIS,
                    o.ORDER_PROPOSAL_RAW
                FROM ART_LIST     a
                JOIN WUP_LIST     w ON a.rn = w.rn
                JOIN DAT_VON_LIST v ON a.rn = v.rn
                JOIN DAT_BIS_LIST b ON a.rn = b.rn
                JOIN ORD_LIST     o ON a.rn = o.rn
            ),
            COMB_MAP AS (
                -- Aggregate per unique combination; use MAX or SUM as needed.
                SELECT
                    ART_ID,
                    WUP_ID,
                    DAT_VON,
                    DAT_BIS,
                    MAX(ORDER_PROPOSAL_RAW) AS ORDER_PROPOSAL
                FROM POS_MAP
                GROUP BY ART_ID, WUP_ID, DAT_VON, DAT_BIS
            )
            SELECT *
            FROM COMB_MAP
        ) m
        WHERE 
              t.ART_ID     = m.ART_ID
          AND t.WUP_ID     = m.WUP_ID
          AND t.DAT_AKTION_VON    = m.DAT_VON
          AND t.DAT_AKTION_BIS    = m.DAT_BIS
          AND t.MANDANT_ID IN (
              SELECT TRIM(value)
              FROM TABLE(split_to_table(:P_MANDANT_IDS, ','))
          )
          AND t.NB_ID IN (
              SELECT TRIM(value)
              FROM TABLE(split_to_table(:P_NB_IDS, ','))
          );

        ------------------------------------------------------------------
        -- STEP 2: MERGE (INSERT if not exists) using same COMB_MAP logic
        ------------------------------------------------------------------
        MERGE INTO DBP_MSI_DATA.TS_WBS_BESTELLVORSCHLAG_IN_PROMO_1 t
        USING (
            WITH
            ART_LIST AS (
                SELECT ROW_NUMBER() OVER (ORDER BY SEQ4()) AS rn,
                       TRIM(value)::NUMBER AS ART_ID
                FROM TABLE(split_to_table(:P_ART_IDS, ','))
            ),
            WUP_LIST AS (
                SELECT ROW_NUMBER() OVER (ORDER BY SEQ4()) AS rn,
                       TRIM(value)::NUMBER AS WUP_ID
                FROM TABLE(split_to_table(:P_WUP_IDS,','))
            ),
            DAT_VON_LIST AS (
                SELECT ROW_NUMBER() OVER (ORDER BY SEQ4()) AS rn,
                       TRIM(value)::DATE AS DAT_VON
                FROM TABLE(split_to_table(:P_DAT_VON_LIST, ','))
            ),
            DAT_BIS_LIST AS (
                SELECT ROW_NUMBER() OVER (ORDER BY SEQ4()) AS rn,
                       TRIM(value)::DATE AS DAT_BIS
                FROM TABLE(split_to_table(:P_DAT_BIS_LIST, ','))
            ),
            ORD_LIST AS (
                SELECT ROW_NUMBER() OVER (ORDER BY SEQ4()) AS rn,
                       TRIM(COALESCE(value, 0))::FLOAT AS ORDER_PROPOSAL_RAW
                FROM TABLE(split_to_table(:P_ORDER_PROPOSAL, ','))
            ),
            POS_MAP AS (
                SELECT
                    a.ART_ID,
                    w.WUP_ID,
                    v.DAT_VON,
                    b.DAT_BIS,
                    o.ORDER_PROPOSAL_RAW
                FROM ART_LIST     a
                JOIN WUP_LIST     w ON a.rn = w.rn
                JOIN DAT_VON_LIST v ON a.rn = v.rn
                JOIN DAT_BIS_LIST b ON a.rn = b.rn
                JOIN ORD_LIST     o ON a.rn = o.rn
            ),
            COMB_MAP AS (
                SELECT
                    ART_ID,
                    WUP_ID,
                    DAT_VON,
                    DAT_BIS,
                    MAX(ORDER_PROPOSAL_RAW) AS ORDER_PROPOSAL
                FROM POS_MAP
                GROUP BY ART_ID, WUP_ID, DAT_VON, DAT_BIS
            ),
            NB_LIST AS (
                SELECT TRIM(value) AS NB_ID
                FROM TABLE(split_to_table(:P_NB_IDS, ','))
            ),
            MANDANT_LIST AS (
                SELECT TRIM(value) AS MANDANT_ID
                FROM TABLE(split_to_table(:P_MANDANT_IDS, ','))
            ),
            BASE_DATA AS (
                SELECT DISTINCT
                    A_ART_WUP.MANDANT_ID,
                    A_ART_WUP.WUP_ID,
                    A_ART_WUP.ANGEBOT_NR,
                    A_ART_WUP.ART_ID,
                    A_ART_WUP.NB_ID,
                    A.DAT_ANGEBOT_GUELTIG_VON,
                    A.DAT_ANGEBOT_GUELTIG_BIS
                FROM DBP_VIEW.V_ANGEBOT_ART_WUP_ZU_1 A_ART_WUP
                JOIN DBP_VIEW.V_ANGEBOT_1 A
                  ON A.ANGEBOT_NR = A_ART_WUP.ANGEBOT_NR
                 AND A.MANDANT_ID = A_ART_WUP.MANDANT_ID
                 AND A.ANGEBOT_GELOESCHT_FG = 0
                JOIN DBP_VIEW.V_TAG_1 T
                  ON A.DAT_ANGEBOT_GUELTIG_VON = T.DAT
                WHERE
                    A_ART_WUP.ART_ID NOT IN (0, -1)
                    AND A.ANGEBOT_STATUS_ID IN (4, 6)
                    AND A.TRANSFER_STATUS_ID IN (0, 3, 5, 6)
                    AND A.ANGEBOT_GELOESCHT_FG = 0
                    AND CASE
                            WHEN A_ART_WUP.MANDANT_ID = 7
                                 AND A.ANGEBOT_TYP_CD NOT IN ('ZAI', 'ZAIR', 'ZAIM') THEN 1
                            WHEN A_ART_WUP.MANDANT_ID = 1
                                 AND A.ANGEBOT_TYP_CD NOT IN ('ZAI', 'ZAIR', 'ZAIM') THEN 1
                            WHEN A.ANGEBOT_TYP_CD NOT IN ('0009', 'ZAI', 'ZAIR', 'ZAIM', '0010', 'ZB09', 'ZB10') THEN 1
                            ELSE 0
                        END = 1
                    AND (
                        A.ANGEBOT_TYP_CD NOT IN ('0005', '0006', '0007', '0008')
                        AND EXISTS (
                            SELECT 1
                            FROM DBP_VIEW.V_ART_LIST_WUP_ZU_PER_1 V_ART_LIST
                            WHERE V_ART_LIST.DAT_VON <= A.DAT_ANGEBOT_GUELTIG_VON
                              AND V_ART_LIST.DAT_BIS >= A.DAT_ANGEBOT_GUELTIG_BIS
                              AND A_ART_WUP.MANDANT_ID = V_ART_LIST.MANDANT_ID
                              AND A_ART_WUP.WUP_ID     = V_ART_LIST.WUP_ID
                              AND A_ART_WUP.ART_ID     = V_ART_LIST.ART_ID
                        )
                        OR A.ANGEBOT_TYP_CD IN ('0005', '0006', '0007', '0008')
                    )
                    AND AKT_WO IN (0, -1)
                    AND T.AKT_KJ = 0
            )
            SELECT DISTINCT
                base.ART_ID,
                base.WUP_ID,
                base.NB_ID,
                base.MANDANT_ID,
                base.DAT_ANGEBOT_GUELTIG_VON AS DAT_VON,
                base.DAT_ANGEBOT_GUELTIG_BIS AS DAT_BIS,
                c.ORDER_PROPOSAL
            FROM BASE_DATA base
            JOIN COMB_MAP c
              ON base.ART_ID                  = c.ART_ID
             AND base.WUP_ID                  = c.WUP_ID
             AND base.DAT_ANGEBOT_GUELTIG_VON = c.DAT_VON
             AND base.DAT_ANGEBOT_GUELTIG_BIS = c.DAT_BIS
            WHERE base.MANDANT_ID IN (SELECT MANDANT_ID FROM MANDANT_LIST)
              AND base.NB_ID      IN (SELECT NB_ID      FROM NB_LIST)
        ) src
        ON  t.MANDANT_ID = src.MANDANT_ID
        AND t.ART_ID     = src.ART_ID
        AND t.WUP_ID     = src.WUP_ID
        AND t.NB_ID      = src.NB_ID
        AND t.DAT_AKTION_VON    = src.DAT_VON
        AND t.DAT_AKTION_BIS    = src.DAT_BIS
        WHEN NOT MATCHED THEN
          INSERT (ART_ID, WUP_ID, NB_ID, MANDANT_ID, DAT_AKTION_VON, DAT_AKTION_BIS,
                  MENGE_BESTELLVORSCHLAG_IN_PROMO_AME, TD_INSERT, TD_UPDATE)
          VALUES (src.ART_ID, src.WUP_ID, src.NB_ID, src.MANDANT_ID,
                  src.DAT_VON, src.DAT_BIS,
                  src.ORDER_PROPOSAL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

        COMMIT;
        RETURN 'Artikel_1 abgespeichert';

    ELSE
        RETURN 'Keine Aktion_1 (P_CONFIRM_FG <> 1)';
    END IF;

END;
$$;