CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KURS_2 as
   -- LOOKUP Berichtskurs pro Mandant_2
   -- Anreicherung Kurs_2-Texte
   -- 2010KW17 Review

   SELECT
   v02.mandant_id, v01.kurstyp_id, v01.von_wrg_id, v01.nach_wrg_id, v01.dat_von, v01.dat_bis, v01.umrechnungskurs,  1 / NULLIFZERO(v01.umrechnungskurs::DECIMAL (9,2)) AS kurs_2, CASE
   WHEN kurs_2 > 1 THEN '1 ' || v01.nach_wrg_id || ' = ' || TRIM(kurs_2) || ' ' || v01.von_wrg_id
   ELSE ''
   END  AS kurs_bez

   FROM dbp_view.v_kurs_2 v01

   JOIN dbp_view.v_mandant_2 v02
   ON v01.von_wrg_id = v02.default_wrg

   WHERE v01.kurstyp_id = 3
   AND v01.dat_bis = '9999-12-31';