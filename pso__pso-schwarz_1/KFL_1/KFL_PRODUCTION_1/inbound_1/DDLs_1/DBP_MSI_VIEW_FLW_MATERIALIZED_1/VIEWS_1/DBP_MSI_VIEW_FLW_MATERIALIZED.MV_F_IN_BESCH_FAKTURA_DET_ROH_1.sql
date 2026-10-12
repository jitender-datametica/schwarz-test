create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_IN_BESCH_FAKTURA_DET_ROH_1(
	FAKTURA_BELEG_ID,
	FAKTURA_BELEG_POS_ID,
	MANDANT_ID,
	DAT_FAKTURA,
	WERK_ID,
	LIEF_POS_TYP_ID,
	IN_ART_ID,
	VORLAGE_BELEG_ID,
	WRG_ID,
	MENGE_FAKTURA_VKME,
	MENGE_FAKTURA_LME,
	VERK_MENGE_FAKTURA_EINH_ID,
	GEWICHT_NETTO_ROH,
	WERT_EK_NETTO_ROH,
	DAT_PREISFINDUNG
) as
   SELECT
    faktura_beleg_id, 
    faktura_beleg_pos_id,
    mandant_id, 
    dat_faktura, 
    werk_id, 
    lief_pos_typ_id, 
    in_art_id, 
    vorlage_beleg_id, 
    wrg_id, 
    menge_faktura_vkme, 
    menge_faktura_lme, 
    verk_menge_faktura_einh_id, 
    gewicht_netto_roh, 
    MAX(wert_ek_netto)          AS wert_ek_netto_roh, 
    dat_preisfindung
    
   FROM
   (
   SELECT
   v01.faktura_beleg_id     AS faktura_beleg_id, 
   v01.faktura_beleg_pos_id AS faktura_beleg_pos_id, 
   v01.mandant_id           AS mandant_id, 
   v01.dat_faktura         AS dat_faktura, 
   v01.werk_id              AS werk_id, 
   v01.lief_pos_typ_id      AS lief_pos_typ_id, 
   v01.in_art_id            AS in_art_id, 
   v01.vorlage_beleg_id     AS vorlage_beleg_id, 
   v400.wrg_id              AS wrg_id, 
   
   v01.vorzeichen_preise, 
   
   v01.vorzeichen_mengen, 
   v01.menge_faktura_vkme, 
   v01.menge_faktura_lme, 
   v01.verk_menge_faktura_einh_id, 
   v01.gewicht_netto_roh, 
   
   CAST(
   CASE
   WHEN v01.wrg_id_v02 <> v01.default_wrg AND v200.wrg_typ_id = 0 -- 0 = Euro
   THEN v01.wert_ek_netto_v02
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id_v02 <> v01.default_wrg AND v200.wrg_typ_id = 1 -- 1 = Landeswaehrung
   THEN ( v01.wert_ek_netto_v02 / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id_v02 = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN v01.wert_ek_netto_v02 * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id_v02 = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN v01.wert_ek_netto_v02
   ELSE 0
   END AS DECIMAL(18,6)
   ) * vorzeichen_preise AS wert_ek_netto, 
    
   v01.dat_preisfindung

   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_IN_BESCH_FAKTURA_DET_ROH_1 v01

   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_1 v300

   JOIN dbp_view.v_mandant_wrg_typ_zu_1 v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id
   LEFT OUTER JOIN dbp_view.v_kurs_1 v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.default_wrg = v500.von_wrg_id
   AND v500.nach_wrg_id ='EUR'
   AND v01.dat_preisfindung BETWEEN v500.dat_von AND v500.dat_bis
   ) dt1

   GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,15;