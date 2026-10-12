create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_CLEAR_STOCK_SPR_ZU_2(
	MANDANT_ID,
	CLEAR_STOCK_ID,
	CLEAR_STOCK_BEZ,
	CLEAR_STOCK_BEZ_DE,
	CLEAR_STOCK_BEZ_CZ,
	CLEAR_STOCK_BEZ_SK,
	CLEAR_STOCK_BEZ_HR,
	CLEAR_STOCK_BEZ_PL,
	CLEAR_STOCK_BEZ_RO,
	CLEAR_STOCK_BEZ_BG
) as
--2026-02-10, dknop, initial

SELECT  MANDANT_ID,
        CLEAR_STOCK_ID,
        CLEAR_STOCK_BEZ,
        CLEAR_STOCK_BEZ_DE,
        CLEAR_STOCK_BEZ_CZ,
        CLEAR_STOCK_BEZ_SK,
        CLEAR_STOCK_BEZ_HR,
        CLEAR_STOCK_BEZ_PL,
        CLEAR_STOCK_BEZ_RO,
        CLEAR_STOCK_BEZ_BG FROM (

    SELECT
        0 AS CLEAR_STOCK_ID,
        'kein'                AS CLEAR_STOCK_BEZ,
        'kein'                AS CLEAR_STOCK_BEZ_DE,
        'Žádný Clear Stock'   AS CLEAR_STOCK_BEZ_CZ,
        'Bez'                 AS CLEAR_STOCK_BEZ_SK,
        'Nema'                AS CLEAR_STOCK_BEZ_HR,
        'Bez CS'              AS CLEAR_STOCK_BEZ_PL,
        'Fara Clear Stock'    AS CLEAR_STOCK_BEZ_RO,
        'без Clear Stock'     AS CLEAR_STOCK_BEZ_BG

    UNION ALL

    SELECT
        1 AS CLEAR_STOCK_ID,
        'Blockbestand'        AS CLEAR_STOCK_BEZ,
        'Blockbestand'        AS CLEAR_STOCK_BEZ_DE,
        'Blokovaná zásoba'    AS CLEAR_STOCK_BEZ_CZ,
        'Blokovaná zásoba'    AS CLEAR_STOCK_BEZ_SK,
        'Blokirana zaliha'    AS CLEAR_STOCK_BEZ_HR,
        'Zapas zablokowany'   AS CLEAR_STOCK_BEZ_PL,
        'Cantitate Blocata'   AS CLEAR_STOCK_BEZ_RO,
        'Блокирана наличност' AS CLEAR_STOCK_BEZ_BG

    UNION ALL

    SELECT
        2 AS CLEAR_STOCK_ID,
        'verfügbarer Bestand' AS CLEAR_STOCK_BEZ,
        'verfügbarer Bestand' AS CLEAR_STOCK_BEZ_DE,
        'Dostupná zásoba'     AS CLEAR_STOCK_BEZ_CZ,
        'Dostupná zásoba'     AS CLEAR_STOCK_BEZ_SK,
        'Raspoloživa zaliha'  AS CLEAR_STOCK_BEZ_HR,
        'Dostępny zapas'      AS CLEAR_STOCK_BEZ_PL,
        'Stoc Disponibil'     AS CLEAR_STOCK_BEZ_RO,
        'Свободна наличност'  AS CLEAR_STOCK_BEZ_BG)
  JOIN dbp_view.v_mandant_2
;
