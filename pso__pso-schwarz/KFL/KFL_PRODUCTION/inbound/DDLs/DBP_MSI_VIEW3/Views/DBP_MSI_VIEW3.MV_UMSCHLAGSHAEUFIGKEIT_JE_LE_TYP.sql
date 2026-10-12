CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_UMSCHLAGSHAEUFIGKEIT_JE_LE_TYP
-- 08.04.2019 pjan1603: view created for AP0038384, SPEC0051699 - Neuer Bericht für Umschlagshäufigkeit je LE-TYP
--          based on the query attached to the Arbeitspaket
-- 10.01.2024 nwag2310: limit on akt_kj >= -2

(
  transportart_id
 , lagereinheit_id
 , mandant_id
 , wup_id
 , nb_id
 , art_id
 , lager_einheiten_typ
 , letzter_lagerplatz_id
 , letzter_lagernummer_id
 , letzter_lagertyp_id
 , dat_quittierung
 , dat_quittierung_vorgaenger
 , anz_tage       -- fact
)
AS
   SELECT
     t02.transportart_id
     , COALESCE(t01.lager_einheit_id_nach
     , t01.lager_einheit_id_von) AS lagereinheit_id
     , t01.mandant_id
     , t01.wup_id
     , t01.nb_id
     , t01.art_id
     , t01.lager_einheiten_typ
     , t03.lagerplatz_id AS letzter_lagerplatz_id
     , t03.lagernummer_id AS letzter_lagernummer_id
     , t03.lagertyp_id  AS letzter_lagertyp_id
     , t01.dat_quittierung
     , COALESCE(MAX(t01.dat_quittierung) OVER (PARTITION BY t01.mandant_id, t01.wup_id
     , COALESCE(t01.lager_einheit_id_nach, t01.lager_einheit_id_von) ORDER BY t01.art_id, t01.dat_quittierung, t01.transport_beleg_id, t01.transport_beleg_pos_id ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)
     , t01.dat_quittierung) AS dat_quittierung_vorgaenger,  (t01.dat_quittierung - dat_quittierung_vorgaenger)  AS anz_tage
   FROM dbp_msi_view3.mv_transportauftrag_det t01
   JOIN dbp_view.v_tag t
	ON t01.dat_quittierung = t.dat
	AND t.akt_kj >= -2
	JOIN dbp_msi_view3.mv_transportauftrag t02
   ON
   (
    t02.dat_quittierung = t01.dat_quittierung
   AND t02.lagernummer_id = t01.lagernummer_id
   AND t02.mandant_id = t01.mandant_id
   AND t02.nb_id = t01.nb_id
   AND t02.transport_beleg_id = t01.transport_beleg_id
   AND t02.wup_id = t01.wup_id
   )
   JOIN (SELECT
     s01.art_id, s01.mandant_id, s01.system_id, s01.wup_id, s01.nb_id, s01.lagerplatz_id, s01.lagernummer_id, s01.lagertyp_id
   FROM dbp_msi_view3.mv_art_lagerplatz_tag s01
   WHERE
    mlgt_fg = 1
   QUALIFY ROW_NUMBER() OVER (PARTITION BY s01.art_id, s01.mandant_id, s01.system_id, s01.wup_id, s01.nb_id ORDER BY s01.dat DESC NULLS LAST) = 1) t03
   ON (
   t03.art_id = t01.art_id
  AND t03.mandant_id = t01.mandant_id
  AND t03.wup_id = t01.wup_id
  AND t03.nb_id = t01.nb_id
 )
 WHERE
  ( von_lagertyp_id IN ('BF1','ÜN1','K01','K02')
   AND
   nach_lagertyp_id IN ('R03','R13')
  )
 OR
  (
   von_lagertyp_id IN ('R03','R13')
   AND (
       nach_lagertyp_id IN ('916','999')
    OR SUBSTR( nach_lagertyp_id, 1, 1) = 'G'
   OR SUBSTR( nach_lagertyp_id, 1, 1) = 'B'
   )
  );