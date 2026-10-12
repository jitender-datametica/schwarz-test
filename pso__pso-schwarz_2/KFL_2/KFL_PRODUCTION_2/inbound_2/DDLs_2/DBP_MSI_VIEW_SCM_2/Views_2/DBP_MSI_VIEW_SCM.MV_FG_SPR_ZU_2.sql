CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_FG_SPR_ZU_2(
	FG_ID,
	FG_BEZ,
    FG_KBEZ,
	FG_BEZ_DE,
	FG_BEZ_CZ,
	FG_BEZ_SK,
	FG_BEZ_HR,
	FG_BEZ_PL,
	FG_BEZ_RO,
	FG_BEZ_BG)
 AS

--2023-06-27, dknop, adding kbez
   SELECT fg_id,
        fg_bez,
        fg_kbez,
        fg_bez_de,
        fg_bez_cz,
        fg_bez_sk,
        fg_bez_hr,
        fg_bez_pl,
        fg_bez_ro,
        fg_bez_bg
        FROM
        (
        SELECT 0  AS fg_id,
            'nein'   AS fg_bez -- standard == DE
           ,''       AS fg_kbez
           ,'nein'   AS fg_bez_de -- DE
           ,'žádný'  AS fg_bez_cz -- CZ
           ,'žiadny' AS fg_bez_sk -- SK
           ,'ne'     AS fg_bez_hr -- HR
           ,'nie'    AS fg_bez_pl -- PL
           ,'nu'     AS fg_bez_ro -- RO
           ,'не'     AS fg_bez_bg -- BG
         ) v01

    UNION ALL
    SELECT fg_id,
        fg_bez,
        fg_kbez,
        fg_bez_de,
        fg_bez_cz,
        fg_bez_sk,
        fg_bez_hr,
        fg_bez_pl,
        fg_bez_ro,
        fg_bez_bg
        FROM
        (
        SELECT 1 AS fg_id,
            'ja'    AS fg_bez -- standard == DE
           ,'X'       AS fg_kbez
           ,'ja'    AS fg_bez_de -- DE
           ,'ano'   AS fg_bez_cz -- CZ
           ,'áno'   AS fg_bez_sk -- SK
           ,'da'    AS fg_bez_hr -- HR
           ,'tak'   AS fg_bez_pl -- PL
           ,'da'    AS fg_bez_ro -- RO
           ,'да'    AS fg_bez_bg -- BG
         ) v02;