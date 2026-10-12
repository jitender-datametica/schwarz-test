CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_MONAT_SPR_ZU_BG_1
(
mo_id
, kj_kurz
, mo_bez
, mo_kbez
, mo_kj_bez
, kjmo
, kj
, mo_bez_lang
)
AS
   SELECT
   v01.mo_id, SUBSTR(CAST(v02.kj AS CHAR(4)),3,2) AS kj_kurz, CAST(v01.mo_bez AS VARCHAR(40)) AS mo_bez, SUBSTR(v01.mo_bez,1,3)||'.' AS mo_kbez, mo_kbez||' '||kj_kurz AS mo_kj_bez, v02.kjmo, v02.kj, CAST (TRIM(v01.mo_bez)|| ' ' ||TRIM(v02.kj) AS VARCHAR(25)) AS mo_bez_lang

   FROM dbp_view.v_monat_spr_zu_1 v01

   JOIN dbp_view.v_monat_1 v02
   ON v01.mo_id = v02.mo_kj

   WHERE v02.kjmo >= 201001
   AND v01.spr_id = 18
   ;