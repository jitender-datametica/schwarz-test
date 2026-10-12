CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_FG_SPR_ZU_2 
--SPEC0113162, AP0091617, 12-05-2021, dknop, initial from LOG
--SPEC0113162, AP0091617, 21-06-2021, dknop, 'ja' part was missing 
(fg_id,
fg_kbez,
fg_bez,
fg_bez_de,
fg_bez_cz,
fg_bez_sk,
fg_bez_hr,
fg_bez_pl,
fg_bez_ro,
fg_bez_bg)
AS
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