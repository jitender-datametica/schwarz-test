-- BG
 -- BG
 -- 2022-08-10, dknop, initial with adding 'n/a'
 -- BG

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_fg_spr_zu_incl_na_1 (fg_id, fg_kbez, fg_bez, fg_bez_de
, fg_bez_cz, fg_bez_sk, fg_bez_hr, fg_bez_pl, fg_bez_ro, fg_bez_bg) AS SELECT 0 AS fg_id,
 ' ' AS fg_kbez,
 'nein' AS fg_bez,
 -- standard == DE
 'nein' AS fg_bez_de,
 -- DE
 'žádný' AS fg_bez_cz,
 -- CZ
 'žiadny' AS fg_bez_sk,
 -- SK
 'ne' AS fg_bez_hr,
 -- HR
 'nie' AS fg_bez_pl,
 -- PL
 'nu' AS fg_bez_ro,
 -- RO
 'не' AS fg_bez_bg
UNION ALL
SELECT 1 AS fg_id,
 'X' AS fg_kbez,
 'ja' AS fg_bez,
 -- standard == DE
 'ja' AS fg_bez_de,
 -- DE
 'ano' AS fg_bez_cz,
 -- CZ
 'áno' AS fg_bez_sk,
 -- SK
 'da' AS fg_bez_hr,
 -- HR
 'tak' AS fg_bez_pl,
 -- PL
 'da' AS fg_bez_ro,
 -- RO
 'да' AS fg_bez_bg
UNION ALL
SELECT -1 AS fg_id,
 'n/a' AS fg_kbez,
 'n/a' AS fg_bez,
 -- standard == DE
 'n/a' AS fg_bez_de,
 -- DE
 'n/a' AS fg_bez_cz,
 -- CZ
 'n/a' AS fg_bez_sk,
 -- SK
 'n/a' AS fg_bez_hr,
 -- HR
 'n/a' AS fg_bez_pl,
 -- PL
 'n/a' AS fg_bez_ro,
 -- RO
 'n/a' AS fg_bez_bg;