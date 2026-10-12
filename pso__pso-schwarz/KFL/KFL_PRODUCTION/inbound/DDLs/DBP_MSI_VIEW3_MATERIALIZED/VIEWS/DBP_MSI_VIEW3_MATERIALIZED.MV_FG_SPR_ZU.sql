create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_FG_SPR_ZU(
	FG_ID,
	FG_KBEZ,
	FG_BEZ,
	FG_BEZ_DE,
	FG_BEZ_CZ,
	FG_BEZ_SK,
	FG_BEZ_HR,
	FG_BEZ_PL,
	FG_BEZ_RO,
	FG_BEZ_BG
) as
SELECT
nein.fg_id,
nein.fg_kbez,
nein.fg_bez,
nein.fg_bez_de,
nein.fg_bez_cz,
nein.fg_bez_sk,
nein.fg_bez_hr,
nein.fg_bez_pl,
nein.fg_bez_ro,
nein.fg_bez_bg
FROM (
SELECT
0 AS fg_id,
' ' AS fg_kbez,
'nein'    AS fg_bez,       -- standard == DE
'nein'    AS fg_bez_de,    -- DE
'žádný'   AS fg_bez_cz,    -- CZ
'žiadny'  AS fg_bez_sk,    -- SK
'ne'      AS fg_bez_hr,    -- HR
'nie'     AS fg_bez_pl,    -- PL
'nu'      AS fg_bez_ro,    -- RO
'не'      AS fg_bez_bg    -- BG
) nein    
UNION ALL
SELECT
oui.fg_id,
oui.fg_kbez,
oui.fg_bez,
oui.fg_bez_de,
oui.fg_bez_cz,
oui.fg_bez_sk,
oui.fg_bez_hr,
oui.fg_bez_pl,
oui.fg_bez_ro,
oui.fg_bez_bg
FROM (
SELECT
1 AS fg_id,
'X' AS fg_kbez,
'ja'  AS fg_bez,       -- standard == DE
'ja'  AS fg_bez_de,    -- DE
'ano' AS fg_bez_cz,    -- CZ
'áno' AS fg_bez_sk,    -- SK
'da'  AS fg_bez_hr,    -- HR
'tak' AS fg_bez_pl,    -- PL
'da'  AS fg_bez_ro,    -- RO
'да'  AS fg_bez_bg    -- BG
) oui;