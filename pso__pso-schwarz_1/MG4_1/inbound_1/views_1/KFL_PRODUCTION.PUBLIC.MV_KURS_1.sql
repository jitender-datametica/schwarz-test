create or replace view KFL_PRODUCTION.PUBLIC.MV_KURS_1(
	MANDANT_ID,
	KURSTYP_ID,
	VON_WRG_ID,
	NACH_WRG_ID,
	DAT_VON,
	DAT_BIS,
	UMRECHNUNGSKURS,
	KURS_1,
	KURS_BEZ
) as
   -- LOOKUP Berichtskurs pro Mandant_1
   -- Anreicherung Kurs_1-Texte
   -- 2010KW17 Review

   SELECT
   v02.mandant_id, v01.kurstyp_id, v01.von_wrg_id, v01.nach_wrg_id, v01.dat_von, v01.dat_bis, v01.umrechnungskurs,  1 / NULLIFZERO(v01.umrechnungskurs::DECIMAL (9,2)) AS kurs_1, CASE
   WHEN kurs_1 > 1 THEN '1 ' || v01.nach_wrg_id || ' = ' || TRIM(kurs_1) || ' ' || v01.von_wrg_id
   ELSE ''
   END  AS kurs_bez

   FROM dbp_view.v_kurs_1 v01

   JOIN dbp_view.v_mandant_1 v02
   ON v01.von_wrg_id = v02.default_wrg

   WHERE v01.kurstyp_id = 3
   AND v01.dat_bis = '9999-12-31';