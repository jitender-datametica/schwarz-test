CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_DIM_OFFSETTING_ACCOUNTS
AS 
SELECT DISTINCT
     OFFSETTING_ACCT_NR AS OFFSETTING_ACCT_NR
    ,DIM.SHORT_NAME_EN AS SHORT_NAME_EN
    ,DIM.LONG_NAME_EN AS LONG_NAME_EN  
    ,COALESCE(DIM2.SHORT_NAME_DE,DIM.SHORT_NAME_DE) AS SHORT_NAME_DE
    ,DIM.LONG_NAME_DE AS LONG_NAME_DE
    FROM
    lec_share.v_fact_accounting_document_line FACT
    LEFT JOIN
        (SELECT
             ACCT_NR
            ,MAX(SHORT_NAME_EN) AS SHORT_NAME_EN
            ,MAX(LONG_NAME_EN) AS LONG_NAME_EN
            ,MAX(SHORT_NAME_DE) AS SHORT_NAME_DE
            ,MAX(LONG_NAME_DE) AS LONG_NAME_DE
        FROM
            lec_share.v_dim_financial_account
        WHERE
            DWH_VALID_FG = TRUE AND CHART_OF_ACCOUNTS_CD = 'LDI1'
            GROUP BY ACCT_NR
        ) DIM
        ON FACT.OFFSETTING_ACCT_NR = DIM.ACCT_NR
    LEFT JOIN
        (SELECT
            SUPPLIER_NR
            ,'' AS SHORT_NAME_EN
            ,'' AS LONG_NAME_EN
            ,SUPPLIER_NAME AS SHORT_NAME_DE
            ,'' AS LONG_NAME_DE
        FROM
            lec_share.v_dim_supplier
        WHERE
            DWH_VALID_FG = TRUE) DIM2
        ON FACT.OFFSETTING_ACCT_NR = DIM2.SUPPLIER_NR
UNION ALL
    SELECT
         '-1'-- OFFSETTING_ACCT_NR
        ,''-- SHORT_NAME_EN
        ,''-- LONG_NAME_EN
        ,''-- SHORT_NAME_DE
        ,''-- LONG_NAME_DE
;
