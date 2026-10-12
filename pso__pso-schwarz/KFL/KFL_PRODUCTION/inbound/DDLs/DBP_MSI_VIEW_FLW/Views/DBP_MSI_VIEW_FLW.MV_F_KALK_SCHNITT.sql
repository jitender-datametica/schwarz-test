CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_KALK_SCHNITT
-- 26.10.2011 system_id entfernt
-- 07.12.2011 AL Einschraenkung auf sek_schl_typ_id in ('M', 'P')
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 02.11.2012 twie: menge aus flw_schnittliste_det hinzugefuegt. Da Feld menge schon exisitert umbenannt in menge_schnittliste
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
mandant_id
--, system_id
, schnittliste_id
, sek_schl_id
, sek_schl_typ_id
, werk_id
, in_art_id
, dat_kalk_ab
, dat_kalk_bis
, fortgesch_kalk_fg
, kalk_nr
, kalk_bez
, kalk_kennz
, in_art_nr
, artikelart_id
, input_material_typ_id
, menge
, preis_kg_org
, preis_kg
, wrg_id_org
, wrg_id
, schnitt_id
, schnitt_verwendung_prozent
, kalk_variante_id
, menge_schnittliste
)
AS
   SELECT
   v14.mandant_id, v14.schnittliste_id, v14.sek_schl_id, v12.sek_schl_typ_id, v10.werk_id, v12.flw_art_id AS in_art_id, v10.dat_kalk_ab, v10.dat_kalk_bis, v10.fortgesch_kalk_fg, v10.kalk_nr, v10.kalk_bez, v10.kalk_kennz, v13.flw_art_nr AS in_art_nr, v13.artikelart_id, v12.input_material_typ_id, v12.menge, v12.preis_kg AS preis_kg_org, CAST(
   CASE
   WHEN v12.wrg_id <> v100.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v12.preis_kg,0)
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v12.wrg_id <> v100.default_wrg AND v200.wrg_typ_id = 1
   THEN ( COALESCE(v12.preis_kg,0) / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v12.wrg_id = v100.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(v12.preis_kg,0) * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v12.wrg_id = v100.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(v12.preis_kg,0)
   END
   AS DECIMAL(18,6))
   AS preis_kg, v12.wrg_id AS wrg_org, v400.wrg_id, v14.schnitt_id, v14.schnitt_verwendung_prozent, v10.kalk_variante_id,  v14.menge as menge_schnittliste

   FROM
   (
   SELECT
   v01.mandant_id, v01.schnittliste_id, v01.werk_id, v01.dat_kalk_ab, v01.dat_kalk_bis, v01.fortgesch_kalk_fg, v01.plan_kalk_id AS kalk_nr, v02.plan_kalk_bez AS kalk_bez, CAST('PK' AS CHAR(3)) AS kalk_kennz, v01.kalk_variante_id AS kalk_variante_id

   FROM dbp_view.v_flw_kalk_plan v01               -- spmeatclpk

   LEFT OUTER JOIN dbp_view.v_flw_kalk_plan_spr_zu v02-- spmeatclpkt

   ON v01.mandant_id = v02.mandant_id
   AND v01.plan_kalk_id = v02.plan_kalk_id

   JOIN dbp_msi.akt_msi_user_spr_zu v03
   ON v02.spr_id = v03.spr_id

   WHERE v01.mandant_id In (1,2)

   UNION ALL

   SELECT
   v04.mandant_id, v04.schnittliste_id, v04.werk_id, v04.dat_kalk_ab, v04.dat_kalk_bis, v04.fortgesch_kalk_fg, v04.materialwert_kalk_id AS kalk_nr, v05.material_kalk_bez AS kalk_bez, 'MWK' AS kalk_kennz, v04.kalk_variante_id AS kalk_variante_id

   FROM dbp_view.v_flw_kalk_material v04               -- spmeatclck

   LEFT OUTER JOIN dbp_view.v_flw_kalk_material_spr_zu v05-- spmeatclckt

   ON v04.mandant_id  = v05.mandant_id
   AND v04.materialwert_kalk_id = v05.materialwert_kalk_id

   JOIN dbp_msi.akt_msi_user_spr_zu v06
   ON v05.spr_id = v06.spr_id

   WHERE v04.mandant_id IN (1,2)
   ) v10

   JOIN dbp_view.v_flw_schnittliste_det v14-- spmeatctlp

   ON v10.mandant_id = v14.mandant_id
   AND v10.kalk_nr = v14.sek_schl_id
   AND v10.schnittliste_id = v14.schnittliste_id

   JOIN dbp_view.v_flw_kalk_preise v12   -- spmeatctlmp

   ON v14.mandant_id = v12.mandant_id
   AND v14.schnittliste_id = v12.schnittliste_id
   AND v14.sek_schl_id = v12.sek_schl_id
   AND v14.sek_schl_typ_id = v12.sek_schl_typ_id
   AND v14.flw_art_id = v12.flw_art_id
   LEFT OUTER JOIN dbp_view.v_flw_art v13            -- mara

   ON v12.mandant_id = v13.mandant_id
   AND v12.flw_art_id = v13.flw_art_id

   JOIN dbp_view.v_mandant v100
   ON v12.mandant_id = v100.mandant_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300

   JOIN dbp_view.v_mandant_wrg_typ_zu v400
   ON v12.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v12.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND v10.dat_kalk_ab BETWEEN v500.dat_von AND v500.dat_bis

   WHERE v14.sek_schl_typ_id in ('M', 'P');