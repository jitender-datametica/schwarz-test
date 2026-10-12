CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.tbl_mv_besch_lief_wup_sum (dat_lief_soll, kunde_id,
lagerort_id, lief_pal_typ_id, lief_typ_id, mandant_id, nb_id, vertr_beleg_typ_id, wup_id, wg_verkett_lief,
menge_lief_ist_kolli, anzahl_packstueck, anzahl_position, menge_lief_ist_bme, betrag_lief_ist, menge_lief_soll_bme,
menge_lief_soll_kolli, werbeware_id, betrag_lief_soll, wrg_id, mandant_id_kunde, vk_netto_lief_soll, vk_netto_lief_ist,
brtvol_ladung_liter, bestellart_id, hu_status_id, brtvol_ladung_liter_gedeckelt, menge_lief_fehl_bme,
menge_lief_fehl_kolli, betrag_lief_fehl, vk_netto_lief_fehl, dat_bis, wrg_typ_id, kurstyp_id) AS SELECT V01.dat_lief_soll
 ,
  CASE
  WHEN SAFE_CAST(ROUND(CAST(V01.kunde_id AS FLOAT64)) AS INTEGER) = 0
  THEN NULL
  ELSE SAFE_CAST(ROUND(CAST(V01.kunde_id AS FLOAT64)) AS INTEGER)
  END AS kunde_id,
 V01.lagerort_id,
 V01.lief_pal_typ_id,
 V01.lief_typ_id,
 V01.mandant_id,
 V01.nb_id,
 V01.vertr_beleg_typ_id,
 V01.wup_id,
 V01.wg_verkett_lief,
 V01.menge_lief_ist_kolli,
 V01.anzahl_packstueck,
 V01.anzahl_position,
 V01.menge_lief_ist_bme,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V01.betrag_lief_ist * V02.umrechnungskurs
  ELSE V01.betrag_lief_ist
  END AS betrag_lief_ist,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE V01.menge_lief_soll_bme
  END AS menge_lief_soll_bme,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE V01.menge_lief_soll_kolli
  END AS menge_lief_soll_kolli,
 V01.werbeware_id,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE V01.betrag_lief_soll
  END AS betrag_lief_soll,
 V01.wrg_id,
  CASE
  WHEN V01.mandant_id_kunde IS NULL OR V01.mandant_id_kunde = 0
  THEN V01.mandant_id
  ELSE V01.mandant_id_kunde
  END AS mandant_id_kunde,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V01.vk_netto_lief_soll * V02.umrechnungskurs
  ELSE V01.vk_netto_lief_soll
  END AS vk_netto_lief_soll,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN V01.vk_netto_lief_ist * V02.umrechnungskurs
  ELSE V01.vk_netto_lief_ist
  END AS vk_netto_lief_ist,
 V01.brtvol_ladung_liter,
 V01.bestellart_id,
 V01.hu_status_id,
 V01.brtvol_ladung_liter_gedeckelt -- die dazugehörige netvol_ladung_liter wird mit FrontEnd Metriken gedeckelt
,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE V01.menge_lief_soll_bme - V01.menge_lief_ist_bme
  END AS menge_lief_fehl_bme,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE V01.menge_lief_soll_kolli - V01.menge_lief_ist_kolli
  END AS menge_lief_fehl_kolli,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE CASE
   WHEN V03.wrg_typ_id = 0
   THEN (V01.betrag_lief_soll - V01.betrag_lief_ist) * V02.umrechnungskurs
   ELSE NULL
   END
  END AS betrag_lief_fehl,
  CASE
  WHEN V03.wrg_typ_id = 0
  THEN (V01.vk_netto_lief_soll - V01.vk_netto_lief_ist) * V02.umrechnungskurs
  ELSE V01.vk_netto_lief_soll - V01.vk_netto_lief_ist
  END AS vk_netto_lief_fehl,
 V02.dat_bis,
 V03.wrg_typ_id,
 V02.kurstyp_id -- ,v01.anzahl_palette_mp
 -- ,v01.anzahl_position_gp
 -- ,v01.menge_lief_ist_kolli_gp

 -- ,v01.anzahl_palette_gp

FROM kfl_production_dbp_view.v_besch_lief_wup_sum AS V01
 INNER JOIN kfl_production_dbp_view.v_kurs AS V02 ON V01.wrg_id = V02.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu AS V03 ON V01.mandant_id = V03.mandant_id
  -- INNER JOIN KFL_PRODUCTION.dbp_msi.akt_msi_user_wrg_typ_zu v04
 -- ON v03.wrg_typ_id = v04.wrg_typ_id

WHERE V02.dat_bis = DATE '9999-12-31'
 AND V02.kurstyp_id = 3
 AND EXTRACT(YEAR FROM V01.dat_lief_soll) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;