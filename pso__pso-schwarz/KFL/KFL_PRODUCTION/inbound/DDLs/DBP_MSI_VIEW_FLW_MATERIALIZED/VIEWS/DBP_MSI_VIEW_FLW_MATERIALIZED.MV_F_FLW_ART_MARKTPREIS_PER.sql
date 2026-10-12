create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_F_FLW_ART_MARKTPREIS_PER(
	MANDANT_ID,
	IN_ART_ID,
	WERK_ID,
	FLW_VERSION_ID,
	BRUTTOPREIS,
	MENGE,
	NICHT_RELEVANT_FG,
	WRG_ID,
	PJWO,
	PJWO_VW
) as
   SELECT
   v01.mandant_id, 
   v01.in_art_id AS in_art_id, 
   v01.werk_id, 
   v01.flw_version_id, 
   
   CASE -- Landesbeleg in Euro wird in Euro angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0 -- 0 = Euro
   THEN v01.bruttopreis
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1 -- 1 = Landeswaehrung
   THEN ( v01.bruttopreis / v500.umrechnungskurs)
   --Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0 -- 0 = Euro
   THEN v01.bruttopreis * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1 -- 1 = Landeswaehrung
   THEN v01.bruttopreis
   END AS bruttopreis, 
   
   v01.menge, 
   v01.nicht_relevant_fg, 
   v400.wrg_id, 
   v01.pjwo, 
   v01.pjwo_vw

   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_F_FLW_ART_MARKTPREIS_PER v01
 
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
   CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300

   -- Aufloesung eingestellte Waehrung nach Kurstyp(0 = Euro,1 = Landeswaehrung)
   JOIN
   dbp_view.v_mandant_wrg_typ_zu v400
   ON v01.mandant_id = v400.mandant_id
   AND v200.wrg_typ_id = v400.wrg_typ_id

   -- Umrechnung Standardkurs, Tageskurs
   JOIN
   dbp_view.v_kurs v500
   ON v300.kurstyp_id = v500.kurstyp_id
   AND v01.wrg_id = v500.von_wrg_id
   AND v500.nach_wrg_id = 'EUR'
   AND v01.dat_aenderung BETWEEN v500.dat_von AND v500.dat_bis
   GROUP BY 1,2,3,4,5,6,7,8,9,10;