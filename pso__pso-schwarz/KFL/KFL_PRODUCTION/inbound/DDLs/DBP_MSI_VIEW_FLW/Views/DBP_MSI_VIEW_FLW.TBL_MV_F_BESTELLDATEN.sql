 CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_BESTELLDATEN
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

(
mandant_id
--, system_id
, lief_beleg_id
, lief_typ_id
, dat_lief_soll
, lief_beleg_pos_id
, werk_id
, in_art_id
, in_art_nr
, basismenge_einh_id
, verk_menge_einh_id
, nettogew
, dat_mat_bereitstllg
, dat_produktion
, in_kunde_id
, verkaufs_beleg_id
, verkaufs_beleg_pos_id
, menge_auftrag_vme_kum
, menge_bes_bme_kum
, menge_bes_bme_kum_kg

)
AS
   SELECT
   v01.mandant_id, 
   v01.lief_beleg_id, 
   v01.lief_typ_id, 
   v01.dat_lief_soll, 
   v02.lief_beleg_pos_id, 
   v02.werk_id, 
   v02.flw_art_id AS in_art_id, 
   v11.flw_art_nr AS in_art_nr, 
   v11.basismenge_einh_id, 
   v02.verk_menge_einh_id, 
   v02.nettogew, 
   v02.dat_mat_bereitstllg, 
   v03.dat_produktion, 
   v01.flw_kunde_id AS in_kunde_id, 
   v04.verkaufs_beleg_id, 
   v04.verkaufs_beleg_pos_id, 
   v04.menge_auftrag_vme_kum, 
   v04.menge_bes_bme_kum, CASE
   WHEN v11.basismenge_einh_id = 'KG' THEN v04.menge_bes_bme_kum
   WHEN v11.basismenge_einh_id = 'ST' THEN CAST(v04.menge_bes_bme_kum * v12.umrech_faktor AS DECIMAL(18,6))
   END
   AS menge_bes_bme_kum_kg

   -- LIKP
   FROM
   dbp_view.v_flw_besch_lief v01

   -- LIPS
   JOIN
   dbp_view.v_flw_besch_lief_det v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.lief_beleg_id = v02.lief_beleg_id

   -- DBP222010
   JOIN
   dbp_view.v_flw_datenpool v03
   ON v02.mandant_id = v03.mandant_id
   AND v02.lief_beleg_id = v03.lief_beleg_id
   AND v02.flw_art_id = v03.flw_art_id
   AND v03.datenpool_satzart_id IN ('KP')

   -- VBAP
   JOIN
   dbp_view.v_flw_kunde_auftrag_det v04
   ON v02.mandant_id = v04.mandant_id
   AND v02.vorlage_beleg_id = v04.verkaufs_beleg_id
   AND v02.flw_art_id = v04.flw_art_id
   LEFT OUTER JOIN dbp_view.v_flw_art v11
   ON v02.mandant_id = v11.mandant_id
   AND v02.flw_art_id = v11.flw_art_id
   LEFT OUTER JOIN dbp_view.v_flw_art_umrech_faktor_per v12
   ON v11.mandant_id = v12.mandant_id
   AND v11.flw_art_id = v12.flw_art_id
   AND (CASE
   WHEN v11.basismenge_einh_id = 'ST' THEN 'KG'
   WHEN v11.basismenge_einh_id = 'KG' THEN 'ST'
   END) = v12.altnv_menge_einh_id

   WHERE v01.mandant_id IN (1,2);
   