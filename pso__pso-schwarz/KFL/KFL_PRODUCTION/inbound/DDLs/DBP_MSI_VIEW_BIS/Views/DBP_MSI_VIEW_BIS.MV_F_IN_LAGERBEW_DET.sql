CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_IN_LAGERBEW_DET
-- 21.09.2015 twie: initial; Ermittlung tatsächliches Lieferdatum
-- 06.10.2015 twie: Erweiterung um lagerbew_beleg_storno_id, menge_bstmg
-- 08.10.2015 twie: erste_we_fg für Datensätze mit ältestem CPU Datum zu einer Bestellbelegposition
-- 18.11.2015 twie: Menge in Basismengeneinheit (BME) errechnen
-- 08.08.2017 ttez: Spalte in_bewart_id aufgenommen
-- 31.08.2017 ttez: Bedingung für BIS-relevante Artikel hinzugefügt in die WHERE-Klausel

(
mandant_id
,lagerbew_beleg_id
,kj
,lagerbew_beleg_pos_id
,in_art_id
,in_lief_id
,werk_id
,best_beleg_id
,best_beleg_pos_id
,dat_buch
--kleinstes dat_erfasst pro Bestellbeleg
,dat_lief_tat
,lagerbew_beleg_storno_id
,soll_haben_kz
,menge_bstmg
,menge_erf
,erfsngs_menge_einh_id
,menge_bme
,erste_we_fg
,in_bewart_id
)
AS
   SELECT
   v02.mandant_id,
   v02.lagerbew_beleg_id,
   v02.kj,
   v02.lagerbew_beleg_pos_id,
   v02.in_art_id,
   v02.in_lief_id,
   v02.werk_id,
   v02.best_beleg_id,
   v02.best_beleg_pos_id,
   v01.dat_buch,
   v03.dat_lief_tat,
   v02.lagerbew_beleg_storno_id,
   v02.soll_haben_kz,
   v02.menge_bstmg,
   v02.menge_erf,
   v02.erfsngs_menge_einh_id,
   CAST(TRUNC(v02.menge_erf / CAST(v04.umrech_faktor AS NUMBER(38,5))) AS NUMBER(38,5)) AS menge_bme,
   CASE WHEN v01.dat_erfasst = v03.dat_lief_tat THEN 1 ELSE 0 END AS erste_we_fg,
   v02.in_bewart_id

   FROM dbp_view.v_in_lagerbew v01
   INNER JOIN dbp_view.v_in_lagerbew_det v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.lagerbew_beleg_id = v02.lagerbew_beleg_id
   AND v01.kj = v02.kj
   LEFT OUTER JOIN
   (
   SELECT
   v02.mandant_id,
   v02.best_beleg_id,
   v02.best_beleg_pos_id,
   MIN(v01.dat_erfasst) AS dat_lief_tat

   FROM dbp_view.v_in_lagerbew v01
   INNER JOIN dbp_view.v_in_lagerbew_det v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.lagerbew_beleg_id = v02.lagerbew_beleg_id
   AND v01.kj = v02.kj

   GROUP BY 1,2,3
   ) v03
   ON  v02.mandant_id = v03.mandant_id
   AND v02.best_beleg_id = v03.best_beleg_id
   AND v02.best_beleg_pos_id = v03.best_beleg_pos_id
   LEFT OUTER JOIN dbp_view.v_in_art_umrech_faktor v04
   ON v02.mandant_id = v04.mandant_id
   AND v02.in_art_id = v04.in_art_id
   AND v02.erfsngs_menge_einh_id = v04.altnv_menge_einh_id

   JOIN dbp_view.v_in_art e
   ON e.mandant_id = v02.mandant_id and e.in_art_id = v02.in_art_id

   WHERE  (e.artikelart_id IN ('ZSAK','ZSDI','ZSKO', 'ZSWG')
   OR SUBSTR( e.in_art_nr, 1, 1) = 'W'
   OR e.in_art_id = -1
   )

;