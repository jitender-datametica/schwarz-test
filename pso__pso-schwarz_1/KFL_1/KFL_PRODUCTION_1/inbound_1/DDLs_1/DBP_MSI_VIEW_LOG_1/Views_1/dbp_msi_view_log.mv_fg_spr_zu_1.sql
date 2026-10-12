CREATE OR REPLACE VIEW dbp_msi_view_log.mv_fg_spr_zu_1
AS
SELECT
non.fg_id,
non.fg_kbez,
non.fg_bez,
non.fg_bez_de,
non.fg_bez_cz,
non.fg_bez_sk,
non.fg_bez_hr,
non.fg_bez_pl,
non.fg_bez_ro,
non.fg_bez_bg
FROM (SELECT
0 AS fg_id,
' ' AS fg_kbez,
'nein'    AS fg_bez       -- standard == DE
,
'nein'    AS fg_bez_de    -- DE
,
'žádný'   AS fg_bez_cz    -- CZ
,
'žiadny'  AS fg_bez_sk    -- SK
,
'ne'      AS fg_bez_hr    -- HR
,
'nie'     AS fg_bez_pl    -- PL
,
'nu'      AS fg_bez_ro    -- RO
,
'не'      AS fg_bez_bg    -- BG
      ) non

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
FROM (SELECT
1 AS fg_id,
'X' AS fg_kbez,
'ja'      AS fg_bez       -- standard == DE
,
'ja'      AS fg_bez_de    -- DE
,
'ano'     AS fg_bez_cz    -- CZ
,
'áno'     AS fg_bez_sk    -- SK
,
'da'      AS fg_bez_hr    -- HR
,
'tak'     AS fg_bez_pl    -- PL
,
'da'      AS fg_bez_ro    -- RO
,
'да'      AS fg_bez_bg    -- BG
     ) oui -- 2020-12-14 | nwag2310 | initial from SCM
;
