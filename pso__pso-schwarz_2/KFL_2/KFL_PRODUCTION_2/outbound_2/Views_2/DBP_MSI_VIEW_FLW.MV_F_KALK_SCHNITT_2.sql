-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
 -- , system_id

-- 02.11.2012 twie: menge aus flw_schnittliste_det_2 hinzugefuegt. Da Feld menge schon exisitert umbenannt in menge_schnittliste

-- 26.10.2011 system_id entfernt
 -- 07.12.2011 AL Einschraenkung auf sek_schl_typ_id in ('M', 'P')

-- 22.10.2012 Filter auf mandant_id in (1,2)
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_kalk_schnitt_2 (mandant_id
, schnittliste_id, sek_schl_id, sek_schl_typ_id, werk_id, in_art_id, dat_kalk_ab, dat_kalk_bis, fortgesch_kalk_fg,
kalk_nr, kalk_bez, kalk_kennz, in_art_nr, artikelart_id, input_material_typ_id, menge, preis_kg_org, preis_kg,
wrg_id_org, wrg_id, schnitt_id, schnitt_verwendung_prozent, kalk_variante_id, menge_schnittliste) AS
-- Landesbeleg in Euro wird in Landeswaehrung angezeigt
 -- Landesbeleg in Landeswaehrung wird in Euro angezeigt

-- spmeatclpk
 -- spmeatclpkt
 -- spmeatclck
 -- spmeatclckt
 -- spmeatctlp
 SELECT V14.mandant_id,
 V14.schnittliste_id,
 V14.sek_schl_id,
 V12.sek_schl_typ_id,
 v10.werk_id,
 V12.flw_art_id AS in_art_id,
 v10.dat_kalk_ab,
 v10.dat_kalk_bis,
 v10.fortgesch_kalk_fg,
 v10.kalk_nr,
 v10.kalk_bez,
 v10.kalk_kennz,
 V13.flw_art_nr AS in_art_nr,
 V13.artikelart_id,
 V12.input_material_typ_id,
 V12.menge,
 V12.preis_kg AS preis_kg_org,
 CAST(CASE
   WHEN V12.wrg_id <> V100.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V12.preis_kg, 0)
   WHEN V12.wrg_id <> V100.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V12.preis_kg, 0) / V500.umrechnungskurs
   WHEN V12.wrg_id = V100.default_wrg AND V200.wrg_typ_id = 0
   THEN COALESCE(V12.preis_kg, 0) * V500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt

   WHEN V12.wrg_id = V100.default_wrg AND V200.wrg_typ_id = 1
   THEN COALESCE(V12.preis_kg, 0)
   ELSE NULL
   END AS NUMERIC) AS preis_kg,
 V12.wrg_id AS wrg_org,
 V400.wrg_id,
 V14.schnitt_id,
 V14.schnitt_verwendung_prozent,
 v10.kalk_variante_id,
 V14.menge AS menge_schnittliste
FROM (SELECT mandant_id,
   schnittliste_id,
   werk_id,
   dat_kalk_ab,
   dat_kalk_bis,
   fortgesch_kalk_fg,
   kalk_nr,
   kalk_bez,
   kalk_kennz,
   kalk_variante_id
  FROM (SELECT V01.mandant_id,
      V01.schnittliste_id,
      V01.werk_id,
      V01.dat_kalk_ab,
      V01.dat_kalk_bis,
      V01.fortgesch_kalk_fg,
      V01.plan_kalk_id AS kalk_nr,
      V02.plan_kalk_bez AS kalk_bez,
      SUBSTR('PK ', 1, 3) AS kalk_kennz,
      V01.kalk_variante_id
     FROM kfl_production_dbp_view.v_flw_kalk_plan_2 AS V01
      LEFT JOIN kfl_production_dbp_view.v_flw_kalk_plan_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.plan_kalk_id
         = V02.plan_kalk_id
      INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V03 ON V02.spr_id = V03.spr_id
     WHERE V01.mandant_id IN (1, 2)
     UNION ALL
     SELECT V04.mandant_id,
      V04.schnittliste_id,
      V04.werk_id,
      V04.dat_kalk_ab,
      V04.dat_kalk_bis,
      V04.fortgesch_kalk_fg,
      V04.materialwert_kalk_id AS kalk_nr,
      V05.material_kalk_bez AS kalk_bez,
      'MWK' AS kalk_kennz,
      V04.kalk_variante_id
     FROM kfl_production_dbp_view.v_flw_kalk_material_2 AS V04
      LEFT JOIN kfl_production_dbp_view.v_flw_kalk_material_spr_zu_2 AS V05 ON V04.mandant_id = V05.mandant_id AND V04.materialwert_kalk_id
         = V05.materialwert_kalk_id
      INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V06 ON V05.spr_id = V06.spr_id
     WHERE V04.mandant_id IN (1, 2)) AS t3) AS v10
 INNER JOIN kfl_production_dbp_view.v_flw_schnittliste_det_2 AS V14 ON v10.mandant_id = V14.mandant_id AND v10.kalk_nr =
    V14.sek_schl_id AND v10.schnittliste_id = V14.schnittliste_id -- spmeatctlmp

 INNER JOIN kfl_production_dbp_view.v_flw_kalk_preise_2 AS V12 ON V14.mandant_id = V12.mandant_id AND V14.schnittliste_id
      = V12.schnittliste_id AND V14.sek_schl_id = V12.sek_schl_id AND V14.sek_schl_typ_id = V12.sek_schl_typ_id AND V14
   .flw_art_id = V12.flw_art_id -- mara_2

 LEFT JOIN kfl_production_dbp_view.v_flw_art_2 AS V13 ON V12.mandant_id = V13.mandant_id AND V12.flw_art_id = V13.flw_art_id
   
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V100 ON V12.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V12.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V12.wrg_id = V500.von_wrg_id
  AND v10.dat_kalk_ab BETWEEN V500.dat_von AND V500.dat_bis
WHERE V500.nach_wrg_id = 'EUR'
 AND V14.sek_schl_typ_id IN ('M', 'P');